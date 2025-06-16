using DUPSS.API.Models.DTOs; 
using DUPSS.API.Models.Objects; // Still needed if 'Role' domain model is referenced elsewhere.

namespace DUPSS.Web.Components.Service
{
   
    public class RoleApiService : GenericApiService<RoleDTO>
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
