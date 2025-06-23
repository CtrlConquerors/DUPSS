using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.DTOs
{
    public class AssessmentResultDTO
    {
        public required string ResultId { get; set; }
        public required string AssessmentId { get; set; }
        public required string MemberId { get; set; }
        public int TotalScore { get; set; }
        public string? Recommendation { get; set; }
        public string RiskLevel { get; set; } = null!;
    }
}
