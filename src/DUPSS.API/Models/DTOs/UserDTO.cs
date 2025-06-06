namespace DUPSS.API.Models.DTOs
{
    public class UserDTO
    {
        public required string UserId { get; set; }
        public required string Username { get; set; }
        public DateOnly? DoB { get; set; }
        public string? PhoneNumber { get; set; }
        public required string Email { get; set; }
        public required string RoleId { get; set; }
        public RoleDTO? Role { get; set; }
        // Exclude navigation properties like MemberAppointments, Courses, etc., to avoid cycles
    }
}
