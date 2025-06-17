using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace DUPSS.API.Services
{
    public class AuthService(AppDbContext context, IConfiguration configuration) : IAuthService
    {
        public static User? user = new()
        {
            UserId = Guid.NewGuid().ToString(), // Generate a unique ID for the user
            Username = string.Empty,           // Placeholder value, will be set during registration
            Email = string.Empty,              // Placeholder value, will be set during registration
            PasswordHash = string.Empty,       // Placeholder value, will be set during registration
            RoleId = "ME"         // Assign a default role ID
        };
        public async Task<string?> LoginAsync(LoginRequest request)
        {
            var userTask = context.User.FirstOrDefaultAsync(u => u.Email == request.Email);
            if (userTask is null)
            {
                return null;
            }

            user = userTask.Result;
            if (new PasswordHasher<User>().VerifyHashedPassword(user, user.PasswordHash, request.Password)
                == PasswordVerificationResult.Failed)
            {
                return null;
            }
            return CreateToken(user);
        }

        public async Task<User?> RegisterAsync(UserDTO request)
        {
            if (await context.User.AnyAsync(u => u.Email == request.Email))
            {
                return null;
            }

            var hashedPassword = new PasswordHasher<User>()
                .HashPassword(user, request.Password);

            user.Email = request.Email;
            user.Username = request.Username;
            user.PhoneNumber = request.PhoneNumber;
            user.DoB = request.DoB ?? DateOnly.FromDateTime(DateTime.Now); // Default to current date if DoB is null
            user.PasswordHash = hashedPassword;
            context.User.Add(user);
            await context.SaveChangesAsync();
            return user;
        }
        private string CreateToken(User user)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.Email, user.Email),
                new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString())
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
}
