using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;
using Supabase;
using System.Text;
using System.Text.Json;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class UserDAO : IUserDAO
    {
        private readonly IDbContextFactory<AppDbContext> _contextFactory;
        private readonly Client _supabaseClient;
        private readonly string _supabaseUrl;
        private readonly string _serviceRoleKey;
        private readonly HttpClient _httpClient;

        public UserDAO(IDbContextFactory<AppDbContext> contextFactory, Client supabaseClient, IConfiguration configuration, HttpClient httpClient)
        {
            _contextFactory = contextFactory;
            _supabaseClient = supabaseClient;
            _supabaseUrl = configuration["Supabase:Url"] ?? throw new ArgumentNullException("Supabase:Url is not configured.");
            _serviceRoleKey = configuration["Supabase:ServiceRoleKey"] ?? throw new ArgumentNullException("Supabase:ServiceRoleKey is not configured.");
            _httpClient = httpClient;
        }

        public async Task<UserDTO> CreateAsync(User user, string password)
        {
            if (string.IsNullOrEmpty(user.Email) || string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.RoleId))
                throw new ArgumentException("Email, username, and role ID are required.");

            try
            {
                await using var context = await _contextFactory.CreateDbContextAsync();
                if (string.IsNullOrEmpty(user.UserId))
                {
                    if (string.IsNullOrEmpty(password))
                        throw new ArgumentException("Password is required when creating a new Supabase user.");

                    var signUpResponse = await _supabaseClient.Auth.SignUp(user.Email, password);
                    if (signUpResponse.User == null)
                        throw new Exception("Failed to create user in Supabase authentication.");

                    user.UserId = signUpResponse.User.Id;
                }

                var role = await context.Role.FirstOrDefaultAsync(r => r.RoleId == user.RoleId);
                if (role == null)
                    throw new Exception($"Role with ID {user.RoleId} does not exist.");

                context.User.Add(user);
                await context.SaveChangesAsync();

                return new UserDTO
                {
                    UserId = user.UserId,
                    Username = user.Username,
                    DoB = user.DoB,
                    PhoneNumber = user.PhoneNumber,
                    Email = user.Email,
                    RoleId = user.RoleId,
                    Role = new RoleDTO
                    {
                        RoleId = role.RoleId,
                        RoleName = role.RoleName
                    }
                };
            }
            catch (Exception ex)
            {
                if (!string.IsNullOrEmpty(user.UserId) && !string.IsNullOrEmpty(password))
                {
                    await DeleteSupabaseUserAsync(user.UserId);
                }
                throw new Exception($"Failed to create user: {ex.Message}", ex);
            }
        }

        public async Task<UserDTO> GetByIdAsync(string userId)
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.User
                .Where(u => u.UserId == userId)
                .Select(u => new UserDTO
                {
                    UserId = u.UserId,
                    Username = u.Username,
                    DoB = u.DoB,
                    PhoneNumber = u.PhoneNumber,
                    Email = u.Email,
                    RoleId = u.RoleId,
                    Role = u.Role != null ? new RoleDTO
                    {
                        RoleId = u.Role.RoleId,
                        RoleName = u.Role.RoleName
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<UserDTO>> GetAllAsync()
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.User
                .Select(u => new UserDTO
                {
                    UserId = u.UserId,
                    Username = u.Username,
                    DoB = u.DoB,
                    PhoneNumber = u.PhoneNumber,
                    Email = u.Email,
                    RoleId = u.RoleId,
                    Role = u.Role != null ? new RoleDTO
                    {
                        RoleId = u.Role.RoleId,
                        RoleName = u.Role.RoleName
                    } : null
                })
                .ToListAsync();
        }

        public async Task<UserDTO> UpdateAsync(User user)
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            var existingUser = await context.User.FindAsync(user.UserId);
            if (existingUser == null)
                throw new Exception($"User with ID {user.UserId} not found.");

            if (existingUser.Email != user.Email)
            {
                try
                {
                    var updateUser = new { email = user.Email };
                    var request = new HttpRequestMessage(HttpMethod.Put, $"{_supabaseUrl}/auth/v1/admin/users/{user.UserId}")
                    {
                        Content = new StringContent(JsonSerializer.Serialize(updateUser), Encoding.UTF8, "application/json")
                    };
                    request.Headers.Add("Authorization", $"Bearer {_serviceRoleKey}");
                    request.Headers.Add("apikey", _serviceRoleKey);

                    var response = await _httpClient.SendAsync(request);
                    if (!response.IsSuccessStatusCode)
                    {
                        var errorContent = await response.Content.ReadAsStringAsync();
                        throw new Exception($"Failed to update email in Supabase: {errorContent}");
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception($"Failed to update email in Supabase: {ex.Message}", ex);
                }
            }

            var role = await context.Role.FirstOrDefaultAsync(r => r.RoleId == user.RoleId);
            if (role == null)
                throw new Exception($"Role with ID {user.RoleId} does not exist.");

            existingUser.Username = user.Username;
            existingUser.Email = user.Email;
            existingUser.PhoneNumber = user.PhoneNumber;
            existingUser.DoB = user.DoB;
            existingUser.RoleId = user.RoleId;

            await context.SaveChangesAsync();
            return new UserDTO
            {
                UserId = existingUser.UserId,
                Username = existingUser.Username,
                DoB = existingUser.DoB,
                PhoneNumber = existingUser.PhoneNumber,
                Email = existingUser.Email,
                RoleId = existingUser.RoleId,
                Role = new RoleDTO
                {
                    RoleId = role.RoleId,
                    RoleName = role.RoleName
                }
            };
        }

        public async Task<bool> DeleteAsync(string userId)
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            var user = await context.User.FindAsync(userId);
            if (user == null)
                return false;

            try
            {
                await DeleteSupabaseUserAsync(userId);
                context.User.Remove(user);
                await context.SaveChangesAsync();
                return true;
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to delete user: {ex.Message}", ex);
            }
        }

        private async Task DeleteSupabaseUserAsync(string userId)
        {
            try
            {
                var request = new HttpRequestMessage(HttpMethod.Delete, $"{_supabaseUrl}/auth/v1/admin/users/{userId}");
                request.Headers.Add("Authorization", $"Bearer {_serviceRoleKey}");
                request.Headers.Add("apikey", _serviceRoleKey);

                var response = await _httpClient.SendAsync(request);
                if (!response.IsSuccessStatusCode)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    throw new Exception($"Failed to delete user from Supabase: {errorContent}");
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Failed to delete user from Supabase: {ex.Message}", ex);
            }
        }
    }
}
