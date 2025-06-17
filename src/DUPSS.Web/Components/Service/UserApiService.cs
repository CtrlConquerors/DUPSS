using DUPSS.API.Models.Common;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects; 

namespace DUPSS.Web.Components.Service
{
    
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

     
        public async Task<UserDTO?> UpdateAsync(UserDTO entity) 
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


            var response = await _httpClient.PutAsJsonAsync("api/Users/Update", entity); 
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<UserDTO>(); 
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

        
        public new async Task<List<UserDTO>> GetAllAsync()
        {

            return await base.GetAllAsync();
        }
        public async Task<List<UserDTO>> GetConsultantsAsync()
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

            var response = await _httpClient.GetAsync("api/Users/consultants");
            if (response.IsSuccessStatusCode)
            {
                var consultants = await response.Content.ReadFromJsonAsync<List<UserDTO>>();
                return consultants ?? new List<UserDTO>();
            }
            else
            {
                Console.WriteLine($"Failed to fetch consultants. Status code: {response.StatusCode}");
                return new List<UserDTO>();
            }
        }
    }
}
