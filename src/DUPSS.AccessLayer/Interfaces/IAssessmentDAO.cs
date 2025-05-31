using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
{
    public interface IAssessmentDAO
    {
        Task<Assessment> CreateAsync(Assessment assessment);
        Task<Assessment> GetByIdAsync(string assessmentId);
        Task<List<Assessment>> GetAllAsync();
        Task<Assessment> UpdateAsync(Assessment assessment);
        Task<bool> DeleteAsync(string assessmentId);
    }
}
