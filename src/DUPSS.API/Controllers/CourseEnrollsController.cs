using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces; // Use the interface for injection
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;
using Npgsql; // For NpgsqlException

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class CourseEnrollsController : ControllerBase
    {
        // Inject the interface, not the concrete class directly, and use 'private readonly'
        private readonly ICourseEnrollDAO _courseEnrollDAO;

        // Constructor now takes ICourseEnrollDAO via dependency injection
        public CourseEnrollsController(ICourseEnrollDAO courseEnrollDAO)
        {
            _courseEnrollDAO = courseEnrollDAO;
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<CourseEnrollDTO>>> GetAll()
        {
            try
            {
                var enrolls = await _courseEnrollDAO.GetAllAsync();
                return Ok(enrolls);
            }
            catch (NpgsqlException ex) // Catch Npgsql specific exceptions
            {
                // Log the exception for debugging purposes
                Console.WriteLine($"Database error in GetAll: {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                // Log general exceptions
                Console.WriteLine($"Internal server error in GetAll: {ex.Message}");
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
            catch (NpgsqlException ex)
            {
                Console.WriteLine($"Database error in GetById({enrollId}): {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Internal server error in GetById({enrollId}): {ex.Message}");
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<ActionResult<CourseEnrollDTO>> Create([FromBody] CourseEnroll courseEnroll)
        {
            try
            {
                var createdEnroll = await _courseEnrollDAO.CreateAsync(courseEnroll);
                // Return 201 CreatedAtAction with the location of the newly created resource
                return CreatedAtAction(nameof(GetById), new { enrollId = createdEnroll.EnrollId }, createdEnroll);
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine($"Database error in Create: {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Internal server error in Create: {ex.Message}");
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPut("Update")]
        public async Task<ActionResult<CourseEnrollDTO>> Update([FromBody] CourseEnroll courseEnroll)
        {
            try
            {
                var updatedEnroll = await _courseEnrollDAO.UpdateAsync(courseEnroll);
                // Return 200 OK with the updated resource
                return Ok(updatedEnroll);
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine($"Database error in Update: {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Internal server error in Update: {ex.Message}");
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
                    // If DAO returns false, it means the entity was not found for deletion
                    return NotFound($"CourseEnroll with ID {enrollId} not found for deletion.");
                // Return 200 OK for successful deletion
                return Ok(result);
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine($"Database error in Delete({enrollId}): {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Internal server error in Delete({enrollId}): {ex.Message}");
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        // Custom endpoint to check for existing enrollments by MemberId and CourseId
        [HttpGet("GetByMemberAndCourse")]
        public async Task<ActionResult<List<CourseEnrollDTO>>> GetByMemberAndCourse([FromQuery] string memberId, [FromQuery] string courseId)
        {
            try
            {
                var enrollments = await _courseEnrollDAO.GetEnrollmentsByMemberAndCourse(memberId, courseId);
                return Ok(enrollments);
            }
            catch (NpgsqlException ex)
            {
                Console.WriteLine($"Database error in GetByMemberAndCourse({memberId}, {courseId}): {ex.Message}");
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Internal server error in GetByMemberAndCourse({memberId}, {courseId}): {ex.Message}");
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
