using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.DTOs
{
    public class AssessmentAnswerDTO
    {
        public required string AnswerId { get; set; }
        public required string QuestionId { get; set; }
        public required string Answer { get; set; } = null!;
        public required string Score { get; set; }
    }
}
