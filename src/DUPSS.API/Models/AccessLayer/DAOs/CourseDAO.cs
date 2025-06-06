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
                ImageUrl = $"images/{course.CourseId}.jpg",
                CreatedDate = course.CreatedDate,
                Status = course.Status,
                Inventory = course.Inventory,
                IsSelected = course.IsSelected
            };
        }

        public async Task<CourseDTO?> GetByIdAsync(string courseId)
        {
            return await _context.Course
                .Where(c => c.CourseId == courseId)
                .Select(c => new CourseDTO
                {
                    CourseId = c.CourseId,
                    TopicId = c.TopicId,
                    CourseName = c.CourseName,
                    CourseType = c.CourseType,
                    StaffId = c.StaffId,
                    ImageUrl = $"images/{c.CourseId}.jpg",
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
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<CourseDTO>> GetAllAsync()
        {
            return await _context.Course
                .Select(c => new CourseDTO
                {
                    CourseId = c.CourseId,
                    TopicId = c.TopicId,
                    CourseName = c.CourseName,
                    CourseType = c.CourseType,
                    StaffId = c.StaffId,
                    ImageUrl = $"images/{c.CourseId}.jpg",
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

            await _context.SaveChangesAsync();
            return new CourseDTO
            {
                CourseId = existingCourse.CourseId,
                TopicId = existingCourse.TopicId,
                CourseName = existingCourse.CourseName,
                CourseType = existingCourse.CourseType,
                StaffId = existingCourse.StaffId,
                ImageUrl = $"images/{existingCourse.CourseId}.jpg",
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
    }
}