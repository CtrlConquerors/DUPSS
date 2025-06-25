using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class AssessmentAnswersController : ControllerBase
    {
        private readonly IAssessmentAnswerDAO _answerDAO;

        public AssessmentAnswersController(AppDbContext context)
        {
            _answerDAO = new AssessmentAnswerDAO(context);
        }

        [HttpGet("GetByQuestionId/{questionId}")]
        public async Task<ActionResult<IEnumerable<AssessmentAnswerDTO>>> GetByQuestionId(string questionId)
        {
            try
            {
                var answers = await _answerDAO.GetByIdAsync(questionId);
                return Ok(answers);
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
        public async Task<ActionResult<AssessmentAnswerDTO>> Create([FromBody] AssessmentAnswer answer)
        {
            try
            {
                var createdAnswer = await _answerDAO.CreateAsync(answer);
                return CreatedAtAction(nameof(GetByQuestionId), new { questionId = createdAnswer.QuestionId }, createdAnswer);
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
        public async Task<ActionResult<AssessmentAnswerDTO>> Update([FromBody] AssessmentAnswer answer)
        {
            try
            {
                var updatedAnswer = await _answerDAO.UpdateAsync(answer);
                if (updatedAnswer == null)
                    return NotFound($"Answer with ID {answer.AnswerId} not found.");
                return Ok(updatedAnswer);
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

        [HttpDelete("Delete/{answerId}")]
        public async Task<ActionResult<bool>> Delete(string answerId)
        {
            try
            {
                var result = await _answerDAO.DeleteAsync(answerId);
                if (!result)
                    return NotFound($"Answer with ID {answerId} not found.");
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