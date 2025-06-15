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
            // Đường dẫn cơ sở vẫn giữ nguyên
            : base(httpClient, "api/Campaigns", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
