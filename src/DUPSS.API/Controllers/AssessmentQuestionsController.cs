using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class AssessmentQuestionsController : ControllerBase
    {
        private readonly IAssessmentQuestionDAO _questionDAO;

        public AssessmentQuestionsController(AppDbContext context)
        {
            _questionDAO = new AssessmentQuestionDAO(context);
        }

        [HttpGet("GetByAssessmentId/{assessmentId}")]
        public async Task<ActionResult<IEnumerable<AssessmentQuestionDTO>>> GetByAssessmentId(string assessmentId, [FromQuery] bool includeAnswers = false)
        {
            try
            {
                var questions = await _questionDAO.GetByIdAsync(assessmentId, includeAnswers);
                return Ok(questions);
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
        public async Task<ActionResult<AssessmentQuestionDTO>> Create([FromBody] AssessmentQuestion question)
        {
            try
            {
                var createdQuestion = await _questionDAO.CreateAsync(question);
                return CreatedAtAction(nameof(GetByAssessmentId), new { assessmentId = createdQuestion.AssessmentId }, createdQuestion);
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
        public async Task<ActionResult<AssessmentQuestionDTO>> Update([FromBody] AssessmentQuestion question)
        {
            try
            {
                var updatedQuestion = await _questionDAO.UpdateAsync(question);
                if (updatedQuestion == null)
                    return NotFound($"Question with ID {question.QuestionId} not found.");
                return Ok(updatedQuestion);
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

        [HttpDelete("Delete/{questionId}")]
        public async Task<ActionResult<bool>> Delete(string questionId)
        {
            try
            {
                var result = await _questionDAO.DeleteAsync(questionId);
                if (!result)
                    return NotFound($"Question with ID {questionId} not found.");
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
    }
}