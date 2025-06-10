using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class RoleApiService : GenericApiService<Role>
    {
        public RoleApiService(HttpClient httpClient)
            : base(httpClient, "api/Roles")
        {
        }
    }
}
