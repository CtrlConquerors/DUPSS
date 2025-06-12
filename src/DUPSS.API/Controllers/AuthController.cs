using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.DTOs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Supabase;

namespace DUPSS.API.Controllers
{
    [ApiController, Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly Client _supabaseClient;
        private readonly UserDAO _userDAO;

        public AuthController(Client supabaseClient, IDbContextFactory<AppDbContext> contextFactory, IConfiguration configuration, HttpClient httpClient)
        {
            _supabaseClient = supabaseClient;
            _userDAO = new UserDAO(contextFactory, supabaseClient, configuration, httpClient);
        }

        [HttpPost("Login")]
        public async Task<ActionResult<LoginResponse>> Login([FromBody] LoginRequest request)
        {
            try
            {
                var session = await _supabaseClient.Auth.SignIn(request.Email, request.Password);
                if (session == null || session.User == null)
                {
                    return Unauthorized("Invalid email or password.");
                }

                var user = await _userDAO.GetByIdAsync(session.User.Id!);
                if (user == null)
                {
                    return NotFound("User not found in database.");
                }

                var cookieOptions = new CookieOptions
                {
                    HttpOnly = true,
                    Secure = true, // Set to false for local testing if not using HTTPS
                    SameSite = SameSiteMode.Strict,
                    Expires = DateTimeOffset.UtcNow.AddHours(1)
                };
                Response.Cookies.Append("authToken", session.AccessToken!, cookieOptions);
                Console.WriteLine($"Set authToken cookie: {session.AccessToken}");

                return Ok(new LoginResponse
                {
                    Token = session.AccessToken!,
                    User = user
                });
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Login error: {ex.Message}");
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Logout")]
        public async Task<ActionResult> Logout()
        {
            try
            {
                await _supabaseClient.Auth.SignOut();
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }

    public class LoginRequest
    {
        public required string Email { get; set; }
        public required string Password { get; set; }
    }

    public class LoginResponse
    {
        public required string Token { get; set; }
        public required UserDTO User { get; set; }
    }
}
