using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DUPSS.Object
{
    public class Course
    {
        [Key]
        public required string CourseId { get; set; }
        [Required]
        public required string TopicId { get; set; }
        [Required, MaxLength(200)]
        public required string CourseName { get; set; }
        [Required, MaxLength(50)]
        public required string CourseType { get; set; }
        [Required]
        public required string StaffId { get; set; }

        // Adjust max length as needed for URL
        [NotMapped]
        [MaxLength(500)]
        public string? ImageUrl { get; set; }

        public CourseTopic? Topic { get; set; }
        public User? Staff { get; set; }
        public List<CourseEnroll> Enrollments { get; set; } = new List<CourseEnroll>();
    }
}
