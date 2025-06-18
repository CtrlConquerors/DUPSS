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
        public AppointmentApiService(HttpClient httpClient)
            : base(httpClient, "api/Appointments")
        {
            _httpClient = httpClient;
        }
        public async Task<string?> GetCurrentUserIdAsync()
        {
            // Removed _authService usage
            return null;
        }
        public async Task<List<AppointmentDTO>> GetAppointmentsForMemberAsync(string memberId)
        {
            // Removed _authService usage
            var response = await _httpClient.GetAsync($"api/Appointments/by-member/{memberId}");
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<List<AppointmentDTO>>() ?? new List<AppointmentDTO>();
            }

            return new List<AppointmentDTO>();
        }
        public async Task<bool> CreateAppointmentAsync(AppointmentDTO appointment)
        {
            // Removed _authService usage
            var response = await _httpClient.PostAsJsonAsync("api/Appointments", appointment);
            return response.IsSuccessStatusCode;
        }




    }
}
