using DUPSS.API.Models.DTOs;
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
    }
}
