using DUPSS.API.Models.Common;
using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class UserApiService : GenericApiService<User>
    {
        private readonly HttpClient _httpClient;

        public UserApiService(HttpClient httpClient)
            : base(httpClient, "api/Users")
        {
            _httpClient = httpClient;
        }

        public async Task<User?> CreateAsync(CreateUserRequest user)
        {
            var response = await _httpClient.PostAsJsonAsync($"api/Users/Create", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<User>();
            }
            return null;
        }
    }
}
