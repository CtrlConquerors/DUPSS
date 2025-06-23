using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.DTOs
{
    public class AssessmentDTO
    {
        public required string AssessmentId { get; set; }
        public required string AssessmentType { get; set; }
        public string? ImageUrl { get; set; }
        public required string? Description { get; set; }
        // Exclude Results to avoid potential cycles; fetch separately if needed
        public List<AssessmentQuestion> Questions { get; set; } = new();
    }
}
