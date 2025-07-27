namespace DUPSS.API.Models.DTOs
{
    public class CourseDTO
    {
        public CourseDTO()
        {

        }
        public required string CourseId { get; set; }
        public required string TopicId { get; set; }
        public required string CourseName { get; set; }
        public required string CourseType { get; set; }
        public required string StaffId { get; set; }
        public string? Description { get; set; } 
        public required string ConsultantId { get; set; }
        public string? ImageUrl { get; set; } 
        public string? ImageUrl2 { get; set; }
        public DateTime CreatedDate { get; set; } 
        public string? Status { get; set; }
        public int Inventory { get; set; } 
        public bool IsSelected { get; set; } 
        public CourseTopicDTO? Topic { get; set; }
        public UserDTO? Staff { get; set; }
        public UserDTO? Consultant { get; set; } 
       
    }
}
