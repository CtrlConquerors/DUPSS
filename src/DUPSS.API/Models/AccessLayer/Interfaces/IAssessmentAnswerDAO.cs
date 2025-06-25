using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IAssessmentAnswerDAO
    {
        Task<IEnumerable<AssessmentAnswerDTO>> GetByIdAsync(string questionId);
        Task<AssessmentAnswerDTO> CreateAsync(AssessmentAnswer answer);
        Task<AssessmentAnswerDTO> UpdateAsync(AssessmentAnswer answer);
        Task<bool> DeleteAsync(string answerId);
    }
}
