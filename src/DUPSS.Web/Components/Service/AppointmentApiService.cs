using DUPSS.API.Models.DTOs; // Important: Use DTOs
using DUPSS.API.Models.Objects; // Still needed if 'Appointment' domain model is referenced elsewhere.

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

        // You can keep custom methods here if needed, ensuring they also work with DTOs.
        // For example, if you had a custom Create method that takes the domain model:
        /*
        public async Task<AppointmentDTO?> CreateAppointmentFromModelAsync(Appointment appointmentModel)
        {
            // Here you would convert the Appointment model to an AppointmentDTO
            // or directly send the model if your API controller accepts it.
            // Given your current API controller might accept 'Appointment',
            // this method would convert it to DTO for the base GenericApiService or send directly.
            // Example if API expects DTO:
            // var appointmentDto = new AppointmentDTO { ... map properties ... };
            // var response = await _httpClient.PostAsJsonAsync("api/Appointments/Create", appointmentDto);

            // If your API's Create method truly accepts the 'Appointment' domain model,
            // and returns 'AppointmentDTO', you might need a specific method here.
            // But usually, API services interact with DTOs directly.

            // Assuming your AppointmentsController.Create method now accepts AppointmentDTO:
            var response = await _httpClient.PostAsJsonAsync($"{_baseEndpoint}/Create", appointmentModel);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<AppointmentDTO>();
            }
            return null;
        }
        */

        // No need for a custom GetAllAsync here if GenericApiService<AppointmentDTO> already handles it.
        // If you had a 'public new async Task<List<Appointment>> GetAllAsync()' previously,
        // it should be removed or changed to return List<AppointmentDTO> and call base.GetAllAsync().
    }
}
