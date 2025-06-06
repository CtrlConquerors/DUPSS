﻿using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
{
    public interface IAssessmentResultDAO
    {
        Task<AssessmentResult> CreateAsync(AssessmentResult assessmentResult);
        Task<AssessmentResult> GetByIdAsync(string resultId);
        Task<List<AssessmentResult>> GetAllAsync();
        Task<AssessmentResult> UpdateAsync(AssessmentResult assessmentResult);
        Task<bool> DeleteAsync(string resultId);
    }
}
