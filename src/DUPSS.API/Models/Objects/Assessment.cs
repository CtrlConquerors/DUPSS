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
        [MaxLength(20)]
        public string Version { get; set; } = "1.0";
        [MaxLength(10)]
        public string Language { get; set; } = "eng";
        public string? Description { get; set; }
        [NotMapped]
        public string? ImageUrl { get; set; }
        public List<AssessmentQuestion> Questions { get; set; } = new();
    }
}
