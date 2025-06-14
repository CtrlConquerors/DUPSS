using DUPSS.API.Models.Objects;
namespace DUPSS.Web.Components.Service
{
    public class AppointmentApiService : GenericApiService<Appointment>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;
        public AppointmentApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Appointments", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
