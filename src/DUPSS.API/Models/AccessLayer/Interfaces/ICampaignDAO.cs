using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface ICampaignDAO
    {
        Task<Campaign> CreateAsync(Campaign campaign);
        Task<Campaign> GetByIdAsync(string campaignId);
        Task<List<Campaign>> GetAllAsync();
        Task<Campaign> UpdateAsync(Campaign campaign);
        Task<bool> DeleteAsync(string campaignId);
    }
}
