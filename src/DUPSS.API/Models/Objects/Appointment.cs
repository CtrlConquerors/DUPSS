using System.ComponentModel.DataAnnotations;

namespace DUPSS.API.Models.Objects
{
    public class Appointment
    {
        [Key]
        public required string AppointmentId { get; set; }
        [Required]
        public required string MemberId { get; set; }
        [Required]
        public required string ConsultantId { get; set; }
        [Required]
        public DateOnly AppointmentDate { get; set; }
        [Required, MaxLength(50)]
        public required string Status { get; set; }
        [MaxLength(100)]
        public required string Topic { get; set; }
        public string? Notes { get; set; }
        public User? Member { get; set; }
        public User? Consultant { get; set; }
    }
}
