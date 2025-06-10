using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class CourseTopic
    {
        [Key]
        public required string TopicId { get; set; }
        [Required, MaxLength(100)]
        public required string TopicName { get; set; }
        public List<Course> Courses { get; set; } = new List<Course>();
    }
}
