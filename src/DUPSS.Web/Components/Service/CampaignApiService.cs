using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CampaignApiService : GenericApiService<Campaign>
    {
        public CampaignApiService(HttpClient httpClient)
            : base(httpClient, "api/Campaigns")
        {

        }
    }
}
