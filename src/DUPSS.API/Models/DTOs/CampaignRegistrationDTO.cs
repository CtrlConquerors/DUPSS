namespace DUPSS.API.Models.DTOs
{
    public class CampaignRegistrationDTO
    {
        public string RegistrationId { get; set; } = default!;
        public string UserId { get; set; } = default!;
        public string CampaignId { get; set; } = default!;
        public DateTime RegisteredAt { get; set; }
    }
}
