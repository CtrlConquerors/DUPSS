using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CourseTopicApiService : GenericApiService<CourseTopic>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public CourseTopicApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/CourseTopics", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
