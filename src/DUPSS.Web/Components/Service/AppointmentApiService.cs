// Fix 1: Ensure consistent API endpoint usage in `AppointmentApiService`
// Fix 2: Align DTO vs domain model expectations
// Fix 3: Rename POST endpoint to accept DTO instead of domain model

using DUPSS.API.Models.DTOs;
using System.Net.Http.Json;

namespace DUPSS.Web.Components.Service
{
    public class AppointmentApiService : GenericApiService<AppointmentDTO>
    {
        private readonly HttpClient _httpClient;

        public AppointmentApiService(HttpClient httpClient)
            : base(httpClient, "api/Appointments")
        {
            _httpClient = httpClient;
        }

        public async Task<List<AppointmentDTO>> GetAppointmentsForMemberAsync(string memberId)
        {
            var response = await _httpClient.GetAsync($"api/Appointments/by-member/{memberId}");
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<List<AppointmentDTO>>() ?? new List<AppointmentDTO>();
            }
            return new List<AppointmentDTO>();
        }

        public async Task<bool> CreateAppointmentAsync(AppointmentDTO appointment)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Appointments/Create", appointment);
            return response.IsSuccessStatusCode;
        }
    }
}
