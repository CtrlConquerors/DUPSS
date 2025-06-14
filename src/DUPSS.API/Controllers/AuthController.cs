using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace DUPSS.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController(IConfiguration configuration) : ControllerBase
    {
        // Initialize the required properties of the User object to resolve CS9035 errors
        public static User user = new()
        {
            UserId = Guid.NewGuid().ToString(), // Generate a unique ID for the user
            Username = string.Empty,           // Placeholder value, will be set during registration
            Email = string.Empty,              // Placeholder value, will be set during registration
            PasswordHash = string.Empty,       // Placeholder value, will be set during registration
            RoleId = "ME"         // Assign a default role ID
        };

        [HttpPost("register")]
        public ActionResult<User> Register(UserDTO request)
        {
            var hashedPassword = new PasswordHasher<User>()
                .HashPassword(user, request.Password);

            user.Email = request.Email;
            user.PasswordHash = hashedPassword;

            return Ok(user);
        }

        [HttpPost("login")]
        public ActionResult<string> Login(LoginRequest request)
        {
            if (user.Email != request.Email)
            {
                return BadRequest("User not found");
            }
            if (new PasswordHasher<User>().VerifyHashedPassword(user, user.PasswordHash, request.Password)
                == PasswordVerificationResult.Failed)
            {
                return BadRequest("Wrong password");
            }

            string token = CreateToken(user);

            return Ok(token);
        }

        private string CreateToken(User user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email)           
            };

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(configuration.GetValue<string>("Appsettings:Token")!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512);

            var tokenDescriptor = new JwtSecurityToken(
                issuer: configuration.GetValue<string>("Appsettings:Issuer"),
                audience: configuration.GetValue<string>("Appsettings:Audience"),
                claims: claims,
                expires: DateTime.Now.AddMinutes(30),
                signingCredentials: creds
                );

            return new JwtSecurityTokenHandler().WriteToken(tokenDescriptor);

        }
    }
