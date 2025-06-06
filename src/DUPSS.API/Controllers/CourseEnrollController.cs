using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CourseEnrollController : ControllerBase
    {
        private readonly CourseEnrollDAO _courseEnrollDAO;

        public CourseEnrollController(AppDbContext context)
        {
            _courseEnrollDAO = new CourseEnrollDAO(context);
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<CourseEnrollDTO>>> GetAll()
        {
            try
            {
                var enrolls = await _courseEnrollDAO.GetAllAsync();
                return Ok(enrolls);
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

        [HttpGet("GetById/{enrollId}")]
        public async Task<ActionResult<CourseEnrollDTO>> GetById(string enrollId)
        {
            try
            {
                var enroll = await _courseEnrollDAO.GetByIdAsync(enrollId);
                if (enroll == null)
                    return NotFound($"CourseEnroll with ID {enrollId} not found.");
                return Ok(enroll);
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
        public async Task<ActionResult<CourseEnrollDTO>> Create([FromBody] CourseEnroll courseEnroll)
        {
            try
            {
                var createdEnroll = await _courseEnrollDAO.CreateAsync(courseEnroll);
                return CreatedAtAction(nameof(GetById), new { enrollId = createdEnroll.EnrollId }, createdEnroll);
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
        public async Task<ActionResult<CourseEnrollDTO>> Update([FromBody] CourseEnroll courseEnroll)
        {
            try
            {
                var updatedEnroll = await _courseEnrollDAO.UpdateAsync(courseEnroll);
                return Ok(updatedEnroll);
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

        [HttpDelete("Delete/{enrollId}")]
        public async Task<ActionResult<bool>> Delete(string enrollId)
        {
            try
            {
                var result = await _courseEnrollDAO.DeleteAsync(enrollId);
                if (!result)
                    return NotFound($"CourseEnroll with ID {enrollId} not found.");
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