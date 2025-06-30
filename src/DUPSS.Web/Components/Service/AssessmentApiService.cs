using DUPSS.API.Models.DTOs;
using System.Buffers.Text;
namespace DUPSS.Web.Components.Service
{
    public class AssessmentApiService : GenericApiService<AssessmentDTO>
    {
        private readonly HttpClient _httpClient;

        public AssessmentApiService(HttpClient httpClient)
            : base(httpClient, "api/Assessments")
        {
            _httpClient = httpClient;
        }
        public async Task<AssessmentResultDTO?> SubmitAssessmentAsync(string assessmentId, AssessmentSubmissionDTO submission)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync($"api/assessments/{assessmentId}/submit", submission);
                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadFromJsonAsync<AssessmentResultDTO>();
                }
                var errorContent = await response.Content.ReadAsStringAsync();
                Console.WriteLine($"Failed to submit assessment: {response.StatusCode} - {errorContent}");
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error submitting assessment: {ex.Message}");
                return null;
            }
        }
    }
}
