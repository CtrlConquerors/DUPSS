using System.ComponentModel.DataAnnotations;
namespace DUPSS.API.Models.Objects
{
    public class BlogTopic
    {
        [Key]
        public required string BlogTopicId { get; set; }
        [Required, MaxLength(100)]
        public required string BlogTopicName { get; set; }
        
        public List<Blog> Blogs { get; set; } = new List<Blog>();
    }
}
