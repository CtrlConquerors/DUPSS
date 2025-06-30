using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;
using System.Linq;

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class AssessmentsController : ControllerBase
    {
        private readonly AssessmentDAO _assessmentDAO;
        private readonly IAssessmentResultDAO _assessmentResultDAO;

        public AssessmentsController(AppDbContext context)
        {
            _assessmentDAO = new AssessmentDAO(context);
            _assessmentResultDAO = new AssessmentResultDAO(context);
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<AssessmentDTO>>> GetAll()
        {
            try
            {
                var assessments = await _assessmentDAO.GetAllAsync();
                return Ok(assessments);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetById/{assessmentId}")]
        public async Task<ActionResult<AssessmentDTO>> GetById(string assessmentId)
        {
            try
            {
                var assessment = await _assessmentDAO.GetByIdAsync(assessmentId);
                if (assessment == null)
                    return NotFound($"Assessment with ID {assessmentId} not found.");
                return Ok(assessment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<ActionResult<AssessmentDTO>> Create([FromBody] Assessment assessment)
        {
            try
            {
                var createdAssessment = await _assessmentDAO.CreateAsync(assessment);
                return CreatedAtAction(nameof(GetById), new { assessmentId = createdAssessment.AssessmentId }, createdAssessment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPut("Update")]
        public async Task<ActionResult<AssessmentDTO>> Update([FromBody] Assessment assessment)
        {
            try
            {
                var updatedAssessment = await _assessmentDAO.UpdateAsync(assessment);
                return Ok(updatedAssessment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpDelete("Delete/{assessmentId}")]
        public async Task<ActionResult<bool>> Delete(string assessmentId)
        {
            try
            {
                var result = await _assessmentDAO.DeleteAsync(assessmentId);
                if (!result)
                    return NotFound($"Assessment with ID {assessmentId} not found.");
                return Ok(result);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("{assessmentId}/submit")]
        public async Task<ActionResult<AssessmentResultDTO>> SubmitAssessment(string assessmentId, [FromBody] AssessmentSubmissionDTO submission)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(submission.MemberId) || string.IsNullOrEmpty(assessmentId))
                    return BadRequest("Invalid member or assessment ID.");

                // Fetch the assessment with questions and answers
                var assessment = await _assessmentDAO.GetByIdAsync(assessmentId, includeQuestions: true, includeAnswers: true);
                if (assessment == null)
                    return NotFound($"Assessment with ID {assessmentId} not found.");

                // Validate non-Text answers (Scale, MultipleChoice, YesNo)
                foreach (var answer in submission.Answers)
                {
                    var selectedAnswer = assessment.Questions
                        .SelectMany(q => q.Answers)
                        .FirstOrDefault(a => a.AnswerId == answer.AnswerId);

                    if (selectedAnswer == null)
                        return BadRequest($"Invalid answer ID: {answer.AnswerId}");
                }

                // Validate Text answers (ensure QuestionId exists and is Text type)
                foreach (var textAnswer in submission.TextAnswers)
                {
                    var question = assessment.Questions
                        .FirstOrDefault(q => q.QuestionId == textAnswer.QuestionId && q.QuestionType == "Text");
                    if (question == null)
                        return BadRequest($"Invalid or non-Text QuestionId: {textAnswer.QuestionId}");
                }

                // Calculate total score and score details in question order
                int totalScore = submission.EarlyTextScore; // Use EarlyTextScore for Text questions
                var scoreDetails = new List<string>();

                // Iterate through questions in their natural order
                foreach (var question in assessment.Questions.OrderBy(q => q.QuestionId))
                {
                    if (question.QuestionType == "Text")
                    {
                        // Find matching Text answer
                        var textAnswer = submission.TextAnswers
                            .FirstOrDefault(ta => ta.QuestionId == question.QuestionId);
                        if (textAnswer != null && !string.IsNullOrEmpty(textAnswer.Answer))
                        {
                            int textScore = (submission.TextAnswers.IndexOf(textAnswer) < 3 && textAnswer.Answer != "0") ? 1 : 0;
                            scoreDetails.Add($"{question.QuestionId}: {textAnswer.Answer} (Score: {textScore})");
                        }
                    }
                    else
                    {
                        // Find matching non-Text answer
                        var answer = submission.Answers
                            .Select(a => assessment.Questions
                                .SelectMany(q => q.Answers)
                                .FirstOrDefault(ans => ans.AnswerId == a.AnswerId && ans.QuestionId == question.QuestionId))
                            .FirstOrDefault(a => a != null);

                        if (answer != null)
                        {
                            totalScore += answer.ScoreValue;
                            scoreDetails.Add($"{answer.QuestionId}: {answer.ScoreDescription ?? answer.Answer} (Score: {answer.ScoreValue})");
                        }
                    }
                }

                // Generate recommendation based on score
                string recommendation = GenerateRecommendation(assessment.AssessmentType, totalScore);

                // Create and save the result
                var result = new AssessmentResult
                {
                    ResultId = Guid.NewGuid().ToString(),
                    AssessmentId = assessmentId,
                    MemberId = submission.MemberId,
                    TotalScore = totalScore,
                    ScoreDetails = string.Join("; ", scoreDetails),
                    Recommendation = recommendation,
                    CompletedOn = DateOnly.FromDateTime(DateTime.Now)
                };

                var createdResult = await _assessmentResultDAO.CreateAsync(result);
                return CreatedAtAction(nameof(AssessmentResultsController.GetById), "AssessmentResults", new { resultId = createdResult.ResultId }, createdResult);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        private string GenerateRecommendation(string assessmentType, int totalScore)
        {
            if (assessmentType == "CRAFFT")
            {
                return totalScore >= 2 ? "Further evaluation recommended due to potential substance use issues." : "Low risk of substance use issues.";
            }
            else if (assessmentType == "ASSIST")
            {
                if (totalScore <= 10) return "Low risk: No intervention needed.";
                else if (totalScore <= 26) return "Moderate risk: Brief intervention recommended.";
                else return "High risk: Referral to specialist treatment recommended.";
            }
            return "No recommendation available.";
        }
    }
}