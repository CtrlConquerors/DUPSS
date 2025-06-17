using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class CampaignRegistration
    {
        [Key]
        public required string RegistrationId { get; set; }

        [Required]
        public required string UserId { get; set; }

        [Required]
        public required string CampaignId { get; set; }

        [Required]
        public DateTime RegisteredAt { get; set; } = DateTime.UtcNow;

        public User? User { get; set; }
        public Campaign? Campaign { get; set; }
    }
}
