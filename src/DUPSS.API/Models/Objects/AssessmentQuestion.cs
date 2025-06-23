using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class AssessmentQuestion
    {
        [Key]
        public required string QuestionId { get; set; }
        [Required, MaxLength(100)]
        public required string AssessmentId { get; set; } = null!;
        [Required, MaxLength(500)]
        public required string Question { get; set; } = null!;
        public List<AssessmentAnswer> Answers { get; set; } = new();
    }
}
