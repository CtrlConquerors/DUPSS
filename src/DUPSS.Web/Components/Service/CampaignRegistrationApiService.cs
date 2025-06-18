using DUPSS.API.Models.DTOs;

namespace DUPSS.Web.Components.Service
{
    public class CampaignRegistrationApiService
    {
        private readonly HttpClient _http;

        public CampaignRegistrationApiService(HttpClient http)
        {
            _http = http;
        }

        public async Task<List<CampaignRegistrationDTO>> GetByUserIdAsync(string userId)
        {
            return await _http.GetFromJsonAsync<List<CampaignRegistrationDTO>>($"api/CampaignRegistration/user/{userId}")
                ?? new List<CampaignRegistrationDTO>();
        }
    }

}
