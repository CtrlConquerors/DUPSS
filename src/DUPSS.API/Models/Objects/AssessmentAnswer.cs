using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class AssessmentAnswer
    {
        [Key]
        public required string AnswerId { get; set; }
        [Required, MaxLength(100)]
        public required string QuestionId { get; set; }
        [Required, MaxLength(500)]
        public required string Answer { get; set; }
        public int ScoreValue { get; set; } // Numeric score
        public string? ScoreDescription { get; set; } // Optional description
    }
}
