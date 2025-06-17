using DUPSS.API.Models.DTOs; // Thêm dòng này để sử dụng DTOs


namespace DUPSS.Web.Components.Service
{

    public class CampaignApiService : GenericApiService<CampaignDTO>
    {
        private readonly HttpClient _httpClient;

        public CampaignApiService(HttpClient httpClient)
            : base(httpClient, "api/Campaigns")
        {
            _httpClient = httpClient;
        }

        public async Task<CampaignDTO?> GetByIdAsync(string campaignId)
        {
            return await _httpClient.GetFromJsonAsync<CampaignDTO>($"api/Campaigns/GetById/{campaignId}");
        }

    }
}
