using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CoursesController : ControllerBase
    {
        private readonly CourseDAO _courseDAO;

        public CoursesController(AppDbContext context)
        {
            _courseDAO = new CourseDAO(context);
        }

        // GET: api/Courses/GetAll
        [HttpGet("GetAll", Name = "GetAll")]
        public async Task<ActionResult<IEnumerable<Course>>> GetAll()
        {
            try
            {
                var courses = await _courseDAO.GetAllAsync();
                return Ok(courses);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                // Handle database-specific errors
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                // Handle other unexpected errors
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
