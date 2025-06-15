using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects; // Vẫn cần nếu 'User' được tham chiếu cho các mục đích khác, mặc dù DTO được ưu tiên cho giao tiếp API.

namespace DUPSS.Web.Components.Service
{
    // Thay đổi kiểu chung từ User thành UserDTO để nhất quán với phản hồi của Controller
    public class UserApiService : GenericApiService<UserDTO>
    {
        private readonly HttpClient _httpClient;
        private readonly AuthService _authService;

        public UserApiService(HttpClient httpClient, AuthService authService)
            : base(httpClient, "api/Users", authService)
        {
            _httpClient = httpClient;
            _authService = authService;
        }

        // Kiểu trả về được thay đổi thành UserDTO? để khớp với việc sử dụng DTO cho việc tạo
        public async Task<UserDTO?> CreateAsync(CreateUserRequest user)
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            }
            else
            {
                _httpClient.DefaultRequestHeaders.Authorization = null;
            }

            var response = await _httpClient.PostAsJsonAsync($"api/Users/Create", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<UserDTO>();
            }
            else
            {
                Console.WriteLine($"Failed to create user. Status code: {response.StatusCode}");
                if (response.Content != null)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error content: {errorContent}");
                }
            }
            return null;
        }

        // Cập nhật tham số và kiểu trả về thành UserDTO? để nhất quán.
        // Điều này giả định điểm cuối Update của UsersController chấp nhận UserDTO và trả về UserDTO.
        public async Task<UserDTO?> UpdateAsync(UserDTO entity) // Thay đổi kiểu tham số thành UserDTO
        {
            var token = _authService.GetToken();
            if (!string.IsNullOrEmpty(token))
            {
                _httpClient.DefaultRequestHeaders.Authorization =
                    new System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", token);
            }
            else
            {
                _httpClient.DefaultRequestHeaders.Authorization = null;
            }

            // Không cần ánh xạ thủ công ở đây nếu 'entity' đã là một UserDTO
            var response = await _httpClient.PutAsJsonAsync("api/Users/Update", entity); // Gửi trực tiếp DTO
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<UserDTO>(); // Mong đợi UserDTO trả về
            }
            else
            {
                Console.WriteLine($"Failed to update user. Status code: {response.StatusCode}");
                if (response.Content != null)
                {
                    var errorContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Error content: {errorContent}");
                }
            }
            return null;
        }

        // Phương thức GetAllAsync này giờ đây trực tiếp trả về List<UserDTO> từ GenericApiService's GetAllAsync
        // vì kiểu chung của UserApiService giờ là UserDTO.
        // Việc ánh xạ thủ công từ UserDTO sang User đã được loại bỏ, đơn giản hóa mã.
        public new async Task<List<UserDTO>> GetAllAsync()
        {
            // GenericApiService<UserDTO> cơ sở giờ đây xử lý điều này một cách chính xác.
            // Bạn có thể đơn giản gọi phương thức cơ sở hoặc giữ cấu trúc này nếu bạn cần logic tùy chỉnh sau này.
            // Hiện tại, chúng ta sẽ đơn giản hóa bằng cách tận dụng GenericApiService.
            return await base.GetAllAsync();
        }
    }
}
