using System.Net.Http.Json;
using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class UsersApiService
    {
        private readonly HttpClient _httpClient;

        public UsersApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<User>> GetAllAsync()
        {
            var result = await _httpClient.GetFromJsonAsync<List<User>>("api/Users/GetAll");
            return result ?? new List<User>();
        }

        public async Task<User?> GetByIdAsync(string userId)
        {
            return await _httpClient.GetFromJsonAsync<User>($"api/Users/GetById/{userId}");
        }

        public async Task<User?> CreateAsync(User user)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Users/Create", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<User>();
            }
            return null;
        }

        public async Task<User?> UpdateAsync(User user)
        {
            var response = await _httpClient.PutAsJsonAsync("api/Users/Update", user);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<User>();
            }
            return null;
        }

        public async Task<bool> DeleteAsync(string userId)
        {
            var response = await _httpClient.DeleteAsync($"api/Users/Delete/{userId}");
            return response.IsSuccessStatusCode;
        }
    }
}