using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class UsersController : ControllerBase
    {
        private readonly UserDAO _userDAO;
        private readonly IConfiguration _configuration;
        private readonly IDbContextFactory<AppDbContext> _contextFactory;

        public UsersController(IDbContextFactory<AppDbContext> contextFactory, IConfiguration configuration)
        {
            _userDAO = new UserDAO(contextFactory);
            _configuration = configuration;
            _contextFactory = contextFactory;
        }

        [HttpPost("Login")]
        public async Task<ActionResult> Login([FromBody] Models.Common.LoginRequest request)
        {
            try
            {
                await using var context = await _contextFactory.CreateDbContextAsync();
                var user = await context.User
                    .Include(u => u.Role)
                    .FirstOrDefaultAsync(u => u.Email == request.Email);

                if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
                    return Unauthorized("Invalid email or password.");

                // Generate JWT
                var claims = new[]
                {
                    new Claim(ClaimTypes.NameIdentifier, user.UserId),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(ClaimTypes.Role, user.RoleId ?? "ME")
                };

                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
                var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
                var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddHours(1),
                signingCredentials: creds);

                return Ok(new
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token)
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
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
                Console.WriteLine($"Creating user with username: {request.User.Username}, email: {request.User.Email}");
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
