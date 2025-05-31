using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    public class AssessmentResultDAO : IAssessmentResultDAO
    {
        private readonly AppDbContext _context;

        public AssessmentResultDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<AssessmentResult> CreateAsync(AssessmentResult assessmentResult)
        {
            _context.AssessmentResults.Add(assessmentResult);
            await _context.SaveChangesAsync();
            return assessmentResult;
        }

        public async Task<AssessmentResult> GetByIdAsync(string resultId)
        {
            return await _context.AssessmentResults
                .Include(ar => ar.Assessment)
                .Include(ar => ar.Member)
                .FirstOrDefaultAsync(ar => ar.ResultId == resultId);
        }

        public async Task<List<AssessmentResult>> GetAllAsync()
        {
            return await _context.AssessmentResults
                .Include(ar => ar.Assessment)
                .Include(ar => ar.Member)
                .ToListAsync();
        }

        public async Task<AssessmentResult> UpdateAsync(AssessmentResult assessmentResult)
        {
            _context.AssessmentResults.Update(assessmentResult);
            await _context.SaveChangesAsync();
            return assessmentResult;
        }

        public async Task<bool> DeleteAsync(string resultId)
        {
            var assessmentResult = await _context.AssessmentResults.FindAsync(resultId);
            if (assessmentResult == null)
                return false;

            _context.AssessmentResults.Remove(assessmentResult);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
