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
            _context.Assessments.Add(assessment);
            await _context.SaveChangesAsync();
            return assessment;
        }

        public async Task<Assessment> GetByIdAsync(string assessmentId)
        {
            return await _context.Assessments
                .Include(a => a.Results)
                .FirstOrDefaultAsync(a => a.AssessmentId == assessmentId);
        }

        public async Task<List<Assessment>> GetAllAsync()
        {
            return await _context.Assessments
                .Include(a => a.Results)
                .ToListAsync();
        }

        public async Task<Assessment> UpdateAsync(Assessment assessment)
        {
            _context.Assessments.Update(assessment);
            await _context.SaveChangesAsync();
            return assessment;
        }

        public async Task<bool> DeleteAsync(string assessmentId)
        {
            var assessment = await _context.Assessments.FindAsync(assessmentId);
            if (assessment == null)
                return false;

            _context.Assessments.Remove(assessment);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
