using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IAssessmentQuestionDAO
    {
        Task<IEnumerable<AssessmentQuestionDTO>> GetByIdAsync(string assessmentId, bool includeAnswers);
        Task<AssessmentQuestionDTO> CreateAsync(AssessmentQuestion question);
        Task<AssessmentQuestionDTO> UpdateAsync(AssessmentQuestion question);
        Task<bool> DeleteAsync(string questionId);
    }
}
