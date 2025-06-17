using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class AuthApiService
    {
        private readonly HttpClient _httpClient;

        public AuthApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<TokenResponseDTO> LoginAsync(string email, string password)
        {
            LoginRequest request = new LoginRequest
            {
                Email = email,
                Password = password
            };

            var response = await _httpClient.PostAsJsonAsync("api/Auth/Login", request);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<TokenResponseDTO>() ?? throw new InvalidOperationException("Failed to deserialize TokenResponseDTO");
            }
            else
            {
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new HttpRequestException($"Login failed: {errorMessage}");
            }
        }

        public async Task<User> RegisterAsync(UserDTO user)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Auth/Register", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<User>() ?? throw new InvalidOperationException("Failed to deserialize User");
            }
            else
            {
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new HttpRequestException($"Register failed: {errorMessage}");
            }
        }

        public async Task<TokenResponseDTO> RefreshTokenAsync(RefreshTokenRequestDTO request)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Auth/Refresh", request);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<TokenResponseDTO>() ?? throw new InvalidOperationException("Failed to deserialize TokenResponseDTO");
            }
            else
            {
                var errorMessage = await response.Content.ReadAsStringAsync();
                throw new HttpRequestException($"Refresh token failed: {errorMessage}");
            }
        }
    }
}
