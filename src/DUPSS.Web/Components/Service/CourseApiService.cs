using System.Net.Http.Json;
using DUPSS.API.Models.Objects; // Adjust namespace as needed

namespace DUPSS.Web.Components.Service
{
    public class CourseApiService
    {
        private readonly HttpClient _httpClient;

        public CourseApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<Course>> GetAllAsync()
        {
            var result = await _httpClient.GetFromJsonAsync<List<Course>>("api/Courses/GetAll");
            return result ?? new List<Course>();
        }

        public async Task<Course?> GetByIdAsync(string courseId)
        {
            return await _httpClient.GetFromJsonAsync<Course>($"api/Courses/GetById/{courseId}");
        }

        public async Task<Course?> CreateAsync(Course course)
        {
            var response = await _httpClient.PostAsJsonAsync("api/Courses/Create", course);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<Course>();
            }
            return null;
        }

        public async Task<Course?> UpdateAsync(Course course)
        {
            var response = await _httpClient.PutAsJsonAsync("api/Courses/Update", course);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<Course>();
            }
            return null;
        }

        public async Task<bool> DeleteAsync(string courseId)
        {
            var response = await _httpClient.DeleteAsync($"api/Courses/Delete/{courseId}");
            return response.IsSuccessStatusCode;
        }
    }
}
