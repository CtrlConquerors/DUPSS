using DUPSS.API.Models.DTOs; // Change to use DTOs
using DUPSS.Web.Components.Service; // Keep this for namespace


namespace DUPSS.Web.Components.Service
{
    // Change the generic type from Course to CourseDTO
    public class CourseApiService : GenericApiService<CourseDTO>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public CourseApiService(HttpClient httpClient, AuthService authService)
            // The base path remains the same
            : base(httpClient, "api/Courses", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
