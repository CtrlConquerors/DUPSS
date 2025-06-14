using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class RoleApiService : GenericApiService<Role>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public RoleApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Roles", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
