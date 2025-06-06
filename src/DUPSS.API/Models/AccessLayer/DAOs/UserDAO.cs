using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Supabase;
using System.Net.Http;
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

        public async Task<User> CreateAsync(User user, string password)
        {
            if (string.IsNullOrEmpty(user.Email) || string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.RoleId))
                throw new ArgumentException("Email, username, and role ID are required.");

            try
            {
                // Only perform Supabase SignUp if UserId is not set (i.e., user not already created in auth.users)
                if (string.IsNullOrEmpty(user.UserId))
                {
                    if (string.IsNullOrEmpty(password))
                        throw new ArgumentException("Password is required when creating a new Supabase user.");

                    var signUpResponse = await _supabaseClient.Auth.SignUp(user.Email, password);
                    if (signUpResponse.User == null)
                        throw new Exception("Failed to create user in Supabase authentication.");

                    user.UserId = signUpResponse.User.Id;
                }

                // Validate RoleId
                await using var context = await _contextFactory.CreateDbContextAsync();
                var role = await context.Role.FirstOrDefaultAsync(r => r.RoleId == user.RoleId);
                if (role == null)
                    throw new Exception($"Role with ID {user.RoleId} does not exist.");

                // Add user to User table
                context.User.Add(user);
                await context.SaveChangesAsync();

                return user;
            }
            catch (Exception ex)
            {
                // Clean up Supabase user if User table insert fails and user was created in this call
                if (!string.IsNullOrEmpty(user.UserId) && !string.IsNullOrEmpty(password))
                {
                    await DeleteSupabaseUserAsync(user.UserId);
                }
                throw new Exception($"Failed to create user: {ex.Message}", ex);
            }
        }

        public async Task<User> GetByIdAsync(string userId)
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.User
                .Include(u => u.Role)
                .Include(u => u.MemberAppointments)
                .Include(u => u.ConsultantAppointments)
                .Include(u => u.Campaigns)
                .Include(u => u.Courses)
                .Include(u => u.Enrollments)
                .Include(u => u.AssessmentResults)
                .Include(u => u.Blogs)
                .FirstOrDefaultAsync(u => u.UserId == userId);
        }

        public async Task<List<User>> GetAllAsync()
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            return await context.User
                .Include(u => u.Role)
                .Include(u => u.MemberAppointments)
                .Include(u => u.ConsultantAppointments)
                .Include(u => u.Campaigns)
                .Include(u => u.Courses)
                .Include(u => u.Enrollments)
                .Include(u => u.AssessmentResults)
                .Include(u => u.Blogs)
                .ToListAsync();
        }

        public async Task<User> UpdateAsync(User user)
        {
            await using var context = await _contextFactory.CreateDbContextAsync();
            var existingUser = await context.User.FindAsync(user.UserId);
            if (existingUser == null)
                throw new Exception($"User with ID {user.UserId} not found.");

            // Check if email is changing
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

            // Validate RoleId
            var role = await context.Role.FirstOrDefaultAsync(r => r.RoleId == user.RoleId);
            if (role == null)
                throw new Exception($"Role with ID {user.RoleId} does not exist.");

            // Update User table
            existingUser.Username = user.Username;
            existingUser.Email = user.Email;
            existingUser.PhoneNumber = user.PhoneNumber;
            existingUser.DoB = user.DoB;
            existingUser.RoleId = user.RoleId;

            await context.SaveChangesAsync();

            return existingUser;
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