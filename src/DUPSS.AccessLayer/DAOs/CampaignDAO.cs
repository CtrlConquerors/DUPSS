using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{

    public class CampaignDAO : ICampaignDAO
    {
        private readonly AppDbContext _context;

        public CampaignDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Campaign> CreateAsync(Campaign campaign)
        {
            _context.Campaigns.Add(campaign);
            await _context.SaveChangesAsync();
            return campaign;
        }

        public async Task<Campaign> GetByIdAsync(string campaignId)
        {
            return await _context.Campaigns
                .Include(c => c.Staff)
                .FirstOrDefaultAsync(c => c.CampaignId == campaignId);
        }

        public async Task<List<Campaign>> GetAllAsync()
        {
            return await _context.Campaigns
                .Include(c => c.Staff)
                .ToListAsync();
        }

        public async Task<Campaign> UpdateAsync(Campaign campaign)
        {
            _context.Campaigns.Update(campaign);
            await _context.SaveChangesAsync();
            return campaign;
        }

        public async Task<bool> DeleteAsync(string campaignId)
        {
            var campaign = await _context.Campaigns.FindAsync(campaignId);
            if (campaign == null)
                return false;

            _context.Campaigns.Remove(campaign);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
