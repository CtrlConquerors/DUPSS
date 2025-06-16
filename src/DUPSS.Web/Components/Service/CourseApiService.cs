using DUPSS.API.Models.DTOs; 
using DUPSS.Web.Components.Service; // Keep this for namespace


namespace DUPSS.Web.Components.Service
{
   
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
