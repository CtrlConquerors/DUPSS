using DUPSS.API.Models.DTOs; // Thêm dòng này để sử dụng DTOs
// using DUPSS.API.Models.Objects; // Không cần thiết nếu bạn chỉ sử dụng DTO ở đây

namespace DUPSS.Web.Components.Service
{
    // Thay đổi kiểu generic từ Campaign sang CampaignDTO
    public class CampaignApiService : GenericApiService<CampaignDTO>
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
