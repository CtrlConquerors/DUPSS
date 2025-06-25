using DUPSS.API.Models.Objects;
using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.DTOs
{
    public class AssessmentAnswerDTO
    {
        public required string AnswerId { get; set; }
        public required string QuestionId { get; set; }
        public required string Answer { get; set; } = null!;
        public int ScoreValue { get; set; } // Numeric score
        public string? ScoreDescription { get; set; } // Optional description

        public AssessmentQuestion? Question { get; set; }
    }
}
