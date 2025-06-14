using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CampaignApiService : GenericApiService<Campaign>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public CampaignApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Campaigns", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
