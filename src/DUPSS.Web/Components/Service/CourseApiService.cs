using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CourseApiService : GenericApiService<Course>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public CourseApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Courses", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
