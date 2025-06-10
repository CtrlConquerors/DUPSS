using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Supabase;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserDAO _userDAO;

        public UsersController(IDbContextFactory<AppDbContext> contextFactory, Client supabaseClient, IConfiguration configuration, HttpClient httpClient)
        {
            _userDAO = new UserDAO(contextFactory, supabaseClient, configuration, httpClient);
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<UserDTO>>> GetAll()
        {
            try
            {
                var users = await _userDAO.GetAllAsync();
                return Ok(users);
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

        [HttpGet("GetById/{userId}")]
        public async Task<ActionResult<UserDTO>> GetById(string userId)
        {
            try
            {
                var user = await _userDAO.GetByIdAsync(userId);
                if (user == null)
                    return NotFound($"User with ID {userId} not found.");
                return Ok(user);
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
        public async Task<ActionResult<UserDTO>> Create([FromBody] CreateUserRequest request)
        {
            try
            {
                var createdUser = await _userDAO.CreateAsync(request.User, request.Password);
                return CreatedAtAction(nameof(GetById), new { userId = createdUser.UserId }, createdUser);
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
        public async Task<ActionResult<UserDTO>> Update([FromBody] User user)
        {
            try
            {
                var updatedUser = await _userDAO.UpdateAsync(user);
                return Ok(updatedUser);
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

        [HttpDelete("Delete/{userId}")]
        public async Task<ActionResult<bool>> Delete(string userId)
        {
            try
            {
                var result = await _userDAO.DeleteAsync(userId);
                if (!result)
                    return NotFound($"User with ID {userId} not found.");
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