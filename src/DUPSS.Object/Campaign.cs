using System.ComponentModel.DataAnnotations;

namespace DUPSS.Object
{
    public class Campaign
    {
        [Key]
        public required string CampaignId { get; set; }
        [Required]
        public required string StaffId { get; set; }
        [Required, MaxLength(200)]
        public required string Title { get; set; }
        public string? Description { get; set; }
        [Required]
        public DateOnly StartDate { get; set; }
        public DateOnly? EndDate { get; set; }
        [Required, MaxLength(50)]
        public required string Status { get; set; }
        public User? Staff { get; set; }
    }
}
