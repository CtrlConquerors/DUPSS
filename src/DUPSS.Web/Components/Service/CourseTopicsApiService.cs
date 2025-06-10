using DUPSS.API.Models.Objects; // Adjust namespace as needed


namespace DUPSS.Web.Components.Service
{
    public class CourseTopicsApiService
    {
        private readonly HttpClient _httpClient;

        public CourseTopicsApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<CourseTopic>> GetAllAsync()
        {
            var result = await _httpClient.GetFromJsonAsync<List<CourseTopic>>("api/CourseTopics/GetAll");
            return result ?? new List<CourseTopic>();
        }

        public async Task<CourseTopic?> GetByIdAsync(string topicId)
        {
            return await _httpClient.GetFromJsonAsync<CourseTopic>($"api/CourseTopics/GetById/{topicId}");
        }

        public async Task<CourseTopic?> CreateAsync(CourseTopic topic)
        {
            var response = await _httpClient.PostAsJsonAsync("api/CourseTopics/Create", topic);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<CourseTopic>();
            }
            return null;
        }

        public async Task<CourseTopic?> UpdateAsync(CourseTopic topic)
        {
            var response = await _httpClient.PutAsJsonAsync("api/CourseTopics/Update", topic);
            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadFromJsonAsync<CourseTopic>();
            }
            return null;
        }

        public async Task<bool> DeleteAsync(string topicId)
        {
            var response = await _httpClient.DeleteAsync($"api/CourseTopics/Delete/{topicId}");
            return response.IsSuccessStatusCode;
        }
    }
}
