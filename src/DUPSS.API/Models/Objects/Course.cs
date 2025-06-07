using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DUPSS.API.Models.Objects
{
    public class Course
    {
        public Course()
        {
            // Default constructor for EF Core
        }

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

        // Navigation properties
        public CourseTopic? Topic { get; set; }
        public User? Staff { get; set; }
        public List<CourseEnroll> Enrollments { get; set; } = new List<CourseEnroll>();

        // [NotMapped] properties for UI display, not stored in DB
        [NotMapped]
        public string? ImageUrl { get; set; } // Already there, good.

        [NotMapped]
        public DateTime CreatedDate { get; set; } // For "CREATED/ADD DATE"

        [NotMapped]
        public string? Status { get; set; } // For "STATUS" (e.g., "AVAILABLE", "UNAVAILABLE")

        [NotMapped]
        public int Inventory { get; set; } // For "INVENTORY"

        [NotMapped]
        public bool IsSelected { get; set; } // For table row selection checkbox
    }
}
