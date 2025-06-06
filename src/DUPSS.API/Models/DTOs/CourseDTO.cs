namespace DUPSS.API.Models.DTOs
{
    public class CourseDTO
    {
        public required string CourseId { get; set; }
        public required string TopicId { get; set; }
        public required string CourseName { get; set; }
        public required string CourseType { get; set; }
        public required string StaffId { get; set; }
        public string? ImageUrl { get; set; } // NotMapped property included
        public DateTime CreatedDate { get; set; } // NotMapped property included
        public string? Status { get; set; } // NotMapped property included
        public int Inventory { get; set; } // NotMapped property included
        public bool IsSelected { get; set; } // NotMapped property included
        public CourseTopicDTO? Topic { get; set; }
        public UserDTO? Staff { get; set; }
        // Exclude Enrollments to avoid cycles; fetch separately if needed
    }
}
