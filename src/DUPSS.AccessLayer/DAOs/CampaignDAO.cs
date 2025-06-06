using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    /// <summary>
    /// Data Access Object (DAO) for managing Campaign entities.
    /// Implements the ICampaignDAO interface for CRUD operations.
    /// </summary>
    public class CampaignDAO : ICampaignDAO
    {
        private readonly AppDbContext _context;

        /// <summary>
        /// Initializes a new instance of the <see cref="CampaignDAO"/> class.
        /// </summary>
        /// <param name="context">The application's database context.</param>
        public CampaignDAO(AppDbContext context)
        {
            _context = context;
        }

        /// <summary>
        /// Creates a new campaign in the database.
        /// </summary>
        /// <param name="campaign">The Campaign object to create.</param>
        /// <returns>The created Campaign object.</returns>
        public async Task<Campaign> CreateAsync(Campaign campaign)
        {
            _context.Campaign.Add(campaign);
            await _context.SaveChangesAsync();
            return campaign;
        }

        /// <summary>
        /// Retrieves a campaign by its unique identifier.
        /// </summary>
        /// <param name="campaignId">The ID of the campaign to retrieve.</param>
        /// <returns>The Campaign object if found, otherwise null.</returns>
        public async Task<Campaign?> GetByIdAsync(string campaignId)
        {
            // Includes the related Staff entity for a more complete object.
            // Using .AsNoTracking() here is generally good practice if the fetched entity
            // is primarily for display and not intended for immediate modification tracking.
            return await _context.Campaign
                .Include(c => c.Staff)
                .AsNoTracking() // Ensure it's not tracked upon retrieval to avoid conflicts
                .FirstOrDefaultAsync(c => c.CampaignId == campaignId);
        }

        /// <summary>
        /// Retrieves all campaigns from the database.
        /// </summary>
        /// <returns>A list of all Campaign objects.</returns>
        public async Task<List<Campaign>> GetAllAsync()
        {
            // Includes the related Staff entity for a more complete object.
            // Using .AsNoTracking() here prevents entities from being tracked after fetching,
            // which helps avoid the "already tracking" error when updating an entity
            // that was previously retrieved and kept in memory.
            return await _context.Campaign
                .Include(c => c.Staff)
                .AsNoTracking() // Add .AsNoTracking() to prevent entities from being tracked after fetching
                .ToListAsync();
        }

        /// <summary>
        /// Updates an existing campaign in the database.
        /// This method now fetches the existing tracked entity and applies changes to it,
        /// avoiding the "already tracking" error.
        /// </summary>
        /// <param name="campaign">The Campaign object with updated information (can be detached).</param>
        /// <returns>The updated Campaign object, or null if not found.</returns>
        public async Task<Campaign?> UpdateAsync(Campaign campaign)
        {
            // Find the existing entity in the database.
            // If it's already tracked by the current DbContext instance, FindAsync will return that instance.
            // Otherwise, it will fetch it from the database and attach it, making it tracked.
            var existingCampaign = await _context.Campaign.FindAsync(campaign.CampaignId);

            if (existingCampaign == null)
            {
                // Entity not found in DB, cannot update
                return null;
            }

            // Update the properties of the existing (tracked) entity with the new values from 'campaign'.
            // This is the correct way to update an entity if it's already in the DbContext's change tracker
            // or if you fetched it specifically for updating.
            // It automatically marks properties as modified if their values have changed.
            _context.Entry(existingCampaign).CurrentValues.SetValues(campaign);

            // If there are navigation properties (like Staff) that might also need updating based on
            // changes to their foreign keys (e.g., StaffId), Entity Framework Core typically handles
            // this automatically when the foreign key property changes.

            await _context.SaveChangesAsync();
            return existingCampaign; // Return the updated, tracked entity
        }

        /// <summary>
        /// Deletes a campaign from the database by its unique identifier.
        /// </summary>
        /// <param name="campaignId">The ID of the campaign to delete.</param>
        /// <returns>True if the campaign was successfully deleted, false otherwise.</returns>
        public async Task<bool> DeleteAsync(string campaignId)
        {
            var campaign = await _context.Campaign.FindAsync(campaignId);
            if (campaign == null)
                return false;

            _context.Campaign.Remove(campaign);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
