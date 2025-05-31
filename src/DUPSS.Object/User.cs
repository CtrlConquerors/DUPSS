using System.ComponentModel.DataAnnotations;

namespace DUPSS.Object
{
    public class User
    {
        [Key]
        public required string UserId { get; set; }
        [Required, MaxLength(100)]
        public required string Username { get; set; }
        public DateOnly? Dob { get; set; }
        [MaxLength(20)]
        public string? PhoneNumber { get; set; }
        [Required, MaxLength(100)]
        public required string Email { get; set; }
        [Required, MaxLength(255)]
        public required string Password { get; set; }
        [Required]
        public required string RoleId { get; set; }
        public Role? Role { get; set; }
        public List<Appointment> MemberAppointments { get; set; } = new List<Appointment>();
        public List<Appointment> ConsultantAppointments { get; set; } = new List<Appointment>();
        public List<Campaign> Campaigns { get; set; } = new List<Campaign>();
        public List<Course> Courses { get; set; } = new List<Course>();
        public List<CourseEnroll> Enrollments { get; set; } = new List<CourseEnroll>();
        public List<AssessmentResult> AssessmentResults { get; set; } = new List<AssessmentResult>();
        public List<Blog> Blogs { get; set; } = new List<Blog>();
    }
}
