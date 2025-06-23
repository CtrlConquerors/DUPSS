using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class AssessmentResult
    {
        [Key]
        public required string ResultId { get; set; }
        [Required]
        public required string AssessmentId { get; set; }
        [Required]
        public required string MemberId { get; set; }
        [Required]
        public int TotalScore { get; set; }
        public string? Recommendation { get; set; }
        public string RiskLevel { get; set; } = null!;
    }
}
