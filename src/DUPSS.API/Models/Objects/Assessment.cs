using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class Assessment
    {
        [Key]
        public required string AssessmentId { get; set; }
        [Required, MaxLength(100)]
        public required string AssessmentType { get; set; }
        public string? Description { get; set; }
        public List<AssessmentResult> Results { get; set; } = new List<AssessmentResult>();
    }
}
