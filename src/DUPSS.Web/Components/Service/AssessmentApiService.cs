using DUPSS.API.Models.DTOs;
using System.Net.Http.Json;
using static System.Net.WebRequestMethods;

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

        public async Task<AssessmentResultDTO?> SubmitAssessmentAsync(string assessmentId, AssessmentResultDTO submission)
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

        public async Task<List<AssessmentResultDTO>> GetResultsByMemberAsync(string memberId)
        {
            try
            {
                return await _httpClient.GetFromJsonAsync<List<AssessmentResultDTO>>($"api/AssessmentResults/ByMember/{memberId}")
                       ?? new List<AssessmentResultDTO>();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error fetching assessment results for member {memberId}: {ex.Message}");
                return new List<AssessmentResultDTO>();
            }
        }
    }
}
