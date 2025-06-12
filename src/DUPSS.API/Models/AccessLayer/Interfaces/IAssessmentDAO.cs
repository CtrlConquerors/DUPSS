using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IAssessmentDAO
    {
        Task<AssessmentDTO> CreateAsync(Assessment assessment);
        Task<AssessmentDTO> GetByIdAsync(string assessmentId);
        Task<List<AssessmentDTO>> GetAllAsync();
        Task<AssessmentDTO> UpdateAsync(Assessment assessment);
        Task<bool> DeleteAsync(string assessmentId);
    }
}
