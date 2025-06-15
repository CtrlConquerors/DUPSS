using DUPSS.API.Models.DTOs; // Important: Use DTOs
using DUPSS.API.Models.Objects; // Still needed if 'Role' domain model is referenced elsewhere.

namespace DUPSS.Web.Components.Service
{
    // Change the generic type from 'Role' to 'RoleDTO'
    // This makes the inherited methods (like GetAllAsync, GetByIdAsync, etc.)
    // operate directly on RoleDTOs.
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

        // No need for custom methods here if GenericApiService<RoleDTO> already handles it.
        // If you had a 'public new async Task<List<Role>> GetAllAsync()' previously,
        // it should be removed or changed to return List<RoleDTO> and call base.GetAllAsync().
    }
}
