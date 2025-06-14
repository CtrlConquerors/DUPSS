using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class BlogApiService : GenericApiService<Blog>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public BlogApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Blogs", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
