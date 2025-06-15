using DUPSS.API.Models.DTOs;
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

        public async Task<CampaignDTO?> GetByIdAsync(string campaignId)
        {
            return await _httpClient.GetFromJsonAsync<CampaignDTO>($"api/Campaigns/GetById/{campaignId}");
        }

    }
}
