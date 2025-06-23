using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DUPSS.API.Models.Objects
{
    public class Assessment
    {
        [Key]
        public required string AssessmentId { get; set; }
        [Required, MaxLength(100)]
        public required string AssessmentType { get; set; }
        public required string? Description { get; set; }
        [NotMapped]
        public string? ImageUrl { get; set; }
        public List<AssessmentQuestion> Questions { get; set; } = new();
    }
}
