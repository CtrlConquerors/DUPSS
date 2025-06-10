using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class Role
    {
        [Key]
        public required string RoleId { get; set; }
        [Required, MaxLength(50)]
        public required string RoleName { get; set; }
        public List<User> Users { get; set; } = new List<User>();
    }
}
