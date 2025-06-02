using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    public class AssessmentDAO : IAssessmentDAO
    {
        private readonly AppDbContext _context;

        public AssessmentDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Assessment> CreateAsync(Assessment assessment)
        {
            _context.Assessment.Add(assessment);
            await _context.SaveChangesAsync();
            return assessment;
        }

        public async Task<Assessment> GetByIdAsync(string assessmentId)
        {
            return await _context.Assessment
                .Include(a => a.Results)
                .FirstOrDefaultAsync(a => a.AssessmentId == assessmentId);
        }

        public async Task<List<Assessment>> GetAllAsync()
        {
            return await _context.Assessment
                .Include(a => a.Results)
                .ToListAsync();
        }

        public async Task<Assessment> UpdateAsync(Assessment assessment)
        {
            _context.Assessment.Update(assessment);
            await _context.SaveChangesAsync();
            return assessment;
        }

        public async Task<bool> DeleteAsync(string assessmentId)
        {
            var assessment = await _context.Assessment.FindAsync(assessmentId);
            if (assessment == null)
                return false;

            _context.Assessment.Remove(assessment);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
