using DUPSS.API.Models.DTOs; // Important: Use DTOs
using DUPSS.API.Models.Objects; // Still needed if 'Appointment' domain model is referenced elsewhere.
using System.Net.Http.Headers;

namespace DUPSS.Web.Components.Service
{
    // Change the generic type from 'Appointment' to 'AppointmentDTO'
    // This makes the inherited methods (like GetAllAsync, GetByIdAsync, etc.)
    // operate directly on AppointmentDTOs.
    public class AppointmentApiService : GenericApiService<AppointmentDTO>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public AppointmentApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Appointments", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
        public async Task<string?> GetCurrentUserIdAsync()
        {
            var token = _authService.GetToken();
            if (string.IsNullOrEmpty(token)) return null;

            var handler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var jwtToken = handler.ReadJwtToken(token);
            var userId = jwtToken.Claims.FirstOrDefault(c => c.Type == "nameid")?.Value;
            return userId;
        }
        public async Task<List<AppointmentDTO>> GetAppointmentsForMemberAsync(string memberId)
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new AuthenticationHeaderValue("Bearer", token);
            }

            var response = await _httpClient.GetAsync($"api/Appointments/by-member/{memberId}");
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<List<AppointmentDTO>>() ?? new List<AppointmentDTO>();
            }

            return new List<AppointmentDTO>();
        }
        public async Task<bool> CreateAppointmentAsync(AppointmentDTO appointment)
        {
            var token = _authService.GetToken();
            _httpClient.DefaultRequestHeaders.Authorization =
                !string.IsNullOrEmpty(token)
                    ? new AuthenticationHeaderValue("Bearer", token)
                    : null;

            var response = await _httpClient.PostAsJsonAsync("api/Appointments", appointment);
            return response.IsSuccessStatusCode;
        }




    }
}
