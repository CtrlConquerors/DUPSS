namespace DUPSS.Web.Components.Service
{
    public class UserApiService : GenericApiService<DUPSS.API.Models.Objects.User>
    {
        public UserApiService(HttpClient httpClient)
            : base(httpClient, "api/Users")
        {
        }
    }
}
