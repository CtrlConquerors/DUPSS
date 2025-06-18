using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class CampaignRegistration
    {
        [Key]
        public string RegistrationId { get; set; } = Guid.NewGuid().ToString();

        [Required]
        public required string MemberId { get; set; }

        [Required]
        public required string CampaignId { get; set; }


        public DateTime RegisteredAt { get; set; } = DateTime.UtcNow;

        public User? User { get; set; }
        public Campaign? Campaign { get; set; }
    }
}
