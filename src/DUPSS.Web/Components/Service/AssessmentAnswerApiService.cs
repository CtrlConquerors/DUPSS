using DUPSS.API.Models.DTOs;
namespace DUPSS.Web.Components.Service
{
    public class AssessmentAnswerApiService : GenericApiService<AssessmentAnswerDTO>
    {
        private readonly HttpClient _httpClient;

        public AssessmentAnswerApiService(HttpClient httpClient)
            : base(httpClient, "api/AssessmentAnswers")
        {
            _httpClient = httpClient;
        }
        public async Task<AssessmentAnswerDTO?> CreateAnswerAsync(AssessmentAnswerDTO answerDto)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync("api/assessmentanswers/Create", answerDto);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<AssessmentAnswerDTO>();
                }
                Console.WriteLine($"Failed to create answer: {response.StatusCode}");
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error creating answer: {ex.Message}");
                return null;
            }
        }

    }
}
