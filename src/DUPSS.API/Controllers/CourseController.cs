using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CourseController : ControllerBase
    {
        private readonly CourseDAO _courseDAO;

        public CourseController(AppDbContext context)
        {
            _courseDAO = new CourseDAO(context);
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<CourseDTO>>> GetAll()
        {
            try
            {
                var courses = await _courseDAO.GetAllAsync();
                return Ok(courses);
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

        [HttpGet("GetById/{courseId}")]
        public async Task<ActionResult<CourseDTO>> GetById(string courseId)
        {
            try
            {
                var course = await _courseDAO.GetByIdAsync(courseId);
                if (course == null)
                    return NotFound($"Course with ID {courseId} not found.");
                return Ok(course);
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
        public async Task<ActionResult<CourseDTO>> Create([FromBody] Course course)
        {
            try
            {
                var createdCourse = await _courseDAO.CreateAsync(course);
                return CreatedAtAction(nameof(GetById), new { courseId = createdCourse.CourseId }, createdCourse);
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
        public async Task<ActionResult<CourseDTO>> Update([FromBody] Course course)
        {
            try
            {
                var updatedCourse = await _courseDAO.UpdateAsync(course);
                return Ok(updatedCourse);
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

        [HttpDelete("Delete/{courseId}")]
        public async Task<ActionResult<bool>> Delete(string courseId)
        {
            try
            {
                var result = await _courseDAO.DeleteAsync(courseId);
                if (!result)
                    return NotFound($"Course with ID {courseId} not found.");
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