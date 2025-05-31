using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
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
