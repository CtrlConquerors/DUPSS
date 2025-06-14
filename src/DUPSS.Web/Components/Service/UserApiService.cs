using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class UserApiService : GenericApiService<User>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public UserApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Users", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }

        public async Task<UserDTO?> CreateAsync(CreateUserRequest user)
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            }
            else
            {
                _httpClient.DefaultRequestHeaders.Authorization = null;
            }

            var response = await _httpClient.PostAsJsonAsync($"api/Users/Create", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<UserDTO>();
            }
            else
            {
                Console.WriteLine($"Failed to create user. Status code: {response.StatusCode}");
                if (response.Content != null)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error content: {errorContent}");
                }
            }
            return null;
        }

        public async Task<User?> UpdateAsync(User entity)
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            }
            else
            {
                _httpClient.DefaultRequestHeaders.Authorization = null;
            }

            var user = new User
            {
                UserId = entity.UserId,
                Username = entity.Username,
                DoB = entity.DoB,
                PhoneNumber = entity.PhoneNumber,
                Email = entity.Email,
                RoleId = entity.RoleId,
                PasswordHash = entity.PasswordHash, // Preserve original PasswordHash
                Role = new Role
                {
                    RoleId = entity.Role?.RoleId ?? "ME",
                    RoleName = entity.Role?.RoleName ?? "Member"
                }
            };

            var response = await _httpClient.PutAsJsonAsync("api/Users/Update", user);
            if (response.IsSuccessStatusCode)
            {
                var updatedUserDto = await response.Content.ReadFromJsonAsync<UserDTO>();
                if (updatedUserDto != null)
                {
                    return new User
                    {
                        UserId = updatedUserDto.UserId,
                        Username = updatedUserDto.Username,
                        DoB = updatedUserDto.DoB,
                        PhoneNumber = updatedUserDto.PhoneNumber,
                        Email = updatedUserDto.Email,
                        RoleId = updatedUserDto.RoleId,
                        PasswordHash = entity.PasswordHash, // Preserve original PasswordHash
                        Role = updatedUserDto.Role != null
                            ? new Role
                            {
                                RoleId = updatedUserDto.Role.RoleId,
                                RoleName = updatedUserDto.Role.RoleName
                            }
                            : null
                    };
                }
            }
            else
            {
                Console.WriteLine($"Failed to update user. Status code: {response.StatusCode}");
                if (response.Content != null)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error content: {errorContent}");
                }
            }
            return null;
        }

        public new async Task<List<User>> GetAllAsync()
        {
            List<User> users = new List<User>();
            var response = await _httpClient.GetAsync("api/Users/GetAll");
            if (response.IsSuccessStatusCode)
            {
                var userDtos = await response.Content.ReadFromJsonAsync<List<UserDTO>>() ?? new List<UserDTO>();
                foreach (var userDto in userDtos)
                {
                    users.Add(new User
                    {
                        UserId = userDto.UserId,
                        Email = userDto.Email,
                        Username = userDto.Username,
                        DoB = userDto.DoB,
                        PhoneNumber = userDto.PhoneNumber,
                        RoleId = userDto.RoleId,
                        PasswordHash = "Placeholder",
                        Role = new Role
                        {
                            RoleId = userDto.Role?.RoleId ?? "ME",
                            RoleName = userDto.Role?.RoleName ?? "Member"
                        }
                    });
                }
                return users;
            }
            else
            {
                Console.WriteLine($"Failed to fetch users. Status code: {response.StatusCode}");
                if (response.Content != null)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error content: {errorContent}");
                }
                return users;
            }
        }
    }
}
