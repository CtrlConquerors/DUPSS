using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class CourseDAO : ICourseDAO
    {
        private readonly AppDbContext _context;

        public CourseDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<CourseDTO> CreateAsync(Course course)
        {
            _context.Course.Add(course);
            await _context.SaveChangesAsync();
            return new CourseDTO
            {
                CourseId = course.CourseId,
                TopicId = course.TopicId,
                CourseName = course.CourseName,
                CourseType = course.CourseType,
                StaffId = course.StaffId,
                Description = course.Description,
                ConsultantId = course.ConsultantId,
                // ImageUrl and ImageUrl2 are [NotMapped] and are now managed by the client (Blazor component)
                // The client will ensure the correct ImageUrl is set on the DTO before sending it.
                // When returning from DAO, we don't fabricate it here.
                ImageUrl = course.ImageUrl, // Pass through the ImageUrl from the incoming course object
                ImageUrl2 = course.ImageUrl2, // Pass through ImageUrl2 if it's ever set
                CreatedDate = course.CreatedDate,
                Status = course.Status,
                Inventory = course.Inventory,
                IsSelected = course.IsSelected
            };
        }

        public async Task<CourseDTO?> GetByIdAsync(string courseId)
        {
            return await _context.Course
                .Include(c => c.Topic) // Eagerly load Topic
                .Include(c => c.Staff) // Eagerly load Staff
                .Include(c => c.Consultant) // Eagerly load Consultant
                .Where(c => c.CourseId == courseId)
                .Select(c => new CourseDTO
                {
                    CourseId = c.CourseId,
                    TopicId = c.TopicId,
                    CourseName = c.CourseName,
                    CourseType = c.CourseType,
                    StaffId = c.StaffId,
                    Description = c.Description,
                    ConsultantId = c.ConsultantId,
                    // ImageUrl and ImageUrl2 are [NotMapped] and should not be fabricated here.
                    // The Blazor component will determine the correct URL based on files in wwwroot.
                    ImageUrl = null, 
                    ImageUrl2 = null, 
                    CreatedDate = c.CreatedDate,
                    Status = c.Status,
                    Inventory = c.Inventory,
                    IsSelected = c.IsSelected,
                    Topic = c.Topic != null ? new CourseTopicDTO
                    {
                        TopicId = c.Topic.TopicId,
                        TopicName = c.Topic.TopicName
                    } : null,
                    Staff = c.Staff != null ? new UserDTO
                    {
                        UserId = c.Staff.UserId,
                        Username = c.Staff.Username,
                        DoB = c.Staff.DoB,
                        PhoneNumber = c.Staff.PhoneNumber,
                        Email = c.Staff.Email,
                        RoleId = c.Staff.RoleId
                    } : null,
                    Consultant = c.Consultant != null ? new UserDTO
                    {
                        UserId = c.Consultant.UserId,
                        Username = c.Consultant.Username,
                        DoB = c.Consultant.DoB,
                        PhoneNumber = c.Consultant.PhoneNumber,
                        Email = c.Consultant.Email,
                        // ImageUrl for Consultant is also not mapped to DB, client can derive
                        ImageUrl = null, // Set to null, client will resolve it
                        RoleId = c.Consultant.RoleId
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<CourseDTO>> GetAllAsync()
        {
            return await _context.Course
                .Include(c => c.Topic) // Eagerly load Topic
                .Include(c => c.Staff) // Eagerly load Staff
                .Include(c => c.Consultant) // Eagerly load Consultant
                .Select(c => new CourseDTO
                {
                    CourseId = c.CourseId,
                    TopicId = c.TopicId,
                    CourseName = c.CourseName,
                    CourseType = c.CourseType,
                    StaffId = c.StaffId,
                    Description = c.Description,
                    ConsultantId = c.ConsultantId,
                    // ImageUrl and ImageUrl2 are [NotMapped] and should not be fabricated here.
                    // The Blazor component will determine the correct URL based on files in wwwroot.
                    ImageUrl = null, // Set to null, the client will resolve it
                    ImageUrl2 = null, // Set to null, the client will resolve it
                    CreatedDate = c.CreatedDate,
                    Status = c.Status,
                    Inventory = c.Inventory,
                    IsSelected = c.IsSelected,
                    Topic = c.Topic != null ? new CourseTopicDTO
                    {
                        TopicId = c.Topic.TopicId,
                        TopicName = c.Topic.TopicName
                    } : null,
                    Staff = c.Staff != null ? new UserDTO
                    {
                        UserId = c.Staff.UserId,
                        Username = c.Staff.Username,
                        DoB = c.Staff.DoB,
                        PhoneNumber = c.Staff.PhoneNumber,
                        Email = c.Staff.Email,
                        RoleId = c.Staff.RoleId
                    } : null,
                    Consultant = c.Consultant != null ? new UserDTO
                    {
                        UserId = c.Consultant.UserId,
                        Username = c.Consultant.Username,
                        DoB = c.Consultant.DoB,
                        PhoneNumber = c.Consultant.PhoneNumber,
                        Email = c.Consultant.Email,
                        // ImageUrl for Consultant is also not mapped to DB, client can derive
                        ImageUrl = null, // Set to null, client will resolve it
                        RoleId = c.Consultant.RoleId
                    } : null
                })
                .ToListAsync();
        }

        public async Task<CourseDTO> UpdateAsync(Course course)
        {
            var existingCourse = await _context.Course.FindAsync(course.CourseId);
            if (existingCourse == null)
                throw new Exception($"Course with ID {course.CourseId} not found.");

            existingCourse.CourseName = course.CourseName;
            existingCourse.CourseType = course.CourseType;
            existingCourse.TopicId = course.TopicId;
            existingCourse.StaffId = course.StaffId;
            existingCourse.Description = course.Description;
            existingCourse.ConsultantId = course.ConsultantId;

            await _context.SaveChangesAsync();
            return new CourseDTO
            {
                CourseId = existingCourse.CourseId,
                TopicId = existingCourse.TopicId,
                CourseName = existingCourse.CourseName,
                CourseType = existingCourse.CourseType,
                StaffId = existingCourse.StaffId,
                Description = existingCourse.Description,
                ConsultantId = existingCourse.ConsultantId,
                // ImageUrl and ImageUrl2 are [NotMapped] and are now managed by the client (Blazor component)
                // The client will ensure the correct ImageUrl is set on the DTO before sending it.
                // When returning from DAO, we don't fabricate it here.
                ImageUrl = course.ImageUrl, // Pass through the ImageUrl from the incoming course object
                ImageUrl2 = course.ImageUrl2, // Pass through ImageUrl2 if it's ever set
                CreatedDate = existingCourse.CreatedDate,
                Status = existingCourse.Status,
                Inventory = existingCourse.Inventory,
                IsSelected = existingCourse.IsSelected
            };
        }

        public async Task<bool> DeleteAsync(string courseId)
        {
            var course = await _context.Course.FindAsync(courseId);
            if (course == null)
                return false;

            _context.Course.Remove(course);
            await _context.SaveChangesAsync();
            return true;
        }
        public async Task<int> CountAsync()
        {
            return await _context.Course.CountAsync();
        }
    }
}
