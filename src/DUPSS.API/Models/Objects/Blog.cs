using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class Blog
    {
        [Key]
        public required string BlogId { get; set; }
        [Required]
        public required string StaffId { get; set; }
        [Required, MaxLength(200)]
        public required string Title { get; set; }
        [Required]
        public required string Content { get; set; }
        [Required, MaxLength(50)]
        public required string Status { get; set; }
        [Required]
        public required string BlogTopicId { get; set; }
        public User? Staff { get; set; }
        public BlogTopic? BlogTopic { get; set; }
    }
}