using DUPSS.API.Models.DTOs; // Thêm dòng này để sử dụng DTOs
// using DUPSS.API.Models.Objects; // Không cần thiết nếu bạn chỉ sử dụng DTO ở đây

namespace DUPSS.Web.Components.Service
{
    // Thay đổi kiểu generic từ Blog sang BlogDTO
    public class BlogApiService : GenericApiService<BlogDTO>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public BlogApiService(HttpClient httpClient, AuthService authService)
            // Đường dẫn cơ sở vẫn giữ nguyên
            : base(httpClient, "api/Blogs", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }
    }
}
