using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class CourseEnrollDAO : ICourseEnrollDAO
    {
        private readonly AppDbContext _context;

        public CourseEnrollDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<CourseEnrollDTO> CreateAsync(CourseEnroll courseEnroll)
        {
            _context.CourseEnroll.Add(courseEnroll);
            await _context.SaveChangesAsync();
            return new CourseEnrollDTO
            {
                EnrollId = courseEnroll.EnrollId,
                MemberId = courseEnroll.MemberId,
                CourseId = courseEnroll.CourseId,
                Status = courseEnroll.Status,
                EnrollDate = courseEnroll.EnrollDate,
                CompleteDate = courseEnroll.CompleteDate
            };
        }

        public async Task<CourseEnrollDTO?> GetByIdAsync(string enrollId)
        {
            return await _context.CourseEnroll
                .Where(ce => ce.EnrollId == enrollId)
                .Select(ce => new CourseEnrollDTO
                {
                    EnrollId = ce.EnrollId,
                    MemberId = ce.MemberId,
                    CourseId = ce.CourseId,
                    Status = ce.Status,
                    EnrollDate = ce.EnrollDate,
                    CompleteDate = ce.CompleteDate,
                    Member = ce.Member != null ? new UserDTO
                    {
                        UserId = ce.Member.UserId,
                        Username = ce.Member.Username,
                        DoB = ce.Member.DoB,
                        PhoneNumber = ce.Member.PhoneNumber,
                        Email = ce.Member.Email,
                        RoleId = ce.Member.RoleId
                    } : null,
                    Course = ce.Course != null ? new CourseDTO
                    {
                        CourseId = ce.Course.CourseId,
                        TopicId = ce.Course.TopicId,
                        CourseName = ce.Course.CourseName,
                        CourseType = ce.Course.CourseType,
                        StaffId = ce.Course.StaffId,
                        ImageUrl = $"images/{ce.Course.CourseId}.jpg",
                        CreatedDate = ce.Course.CreatedDate,
                        Status = ce.Course.Status,
                        Inventory = ce.Course.Inventory,
                        IsSelected = ce.Course.IsSelected
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<CourseEnrollDTO>> GetAllAsync()
        {
            return await _context.CourseEnroll
                .Select(ce => new CourseEnrollDTO
                {
                    EnrollId = ce.EnrollId,
                    MemberId = ce.MemberId,
                    CourseId = ce.CourseId,
                    Status = ce.Status,
                    EnrollDate = ce.EnrollDate,
                    CompleteDate = ce.CompleteDate,
                    Member = ce.Member != null ? new UserDTO
                    {
                        UserId = ce.Member.UserId,
                        Username = ce.Member.Username,
                        DoB = ce.Member.DoB,
                        PhoneNumber = ce.Member.PhoneNumber,
                        Email = ce.Member.Email,
                        RoleId = ce.Member.RoleId
                    } : null,
                    Course = ce.Course != null ? new CourseDTO
                    {
                        CourseId = ce.Course.CourseId,
                        TopicId = ce.Course.TopicId,
                        CourseName = ce.Course.CourseName,
                        CourseType = ce.Course.CourseType,
                        StaffId = ce.Course.StaffId,
                        ImageUrl = $"images/{ce.Course.CourseId}.jpg",
                        CreatedDate = ce.Course.CreatedDate,
                        Status = ce.Course.Status,
                        Inventory = ce.Course.Inventory,
                        IsSelected = ce.Course.IsSelected
                    } : null
                })
                .ToListAsync();
        }

        public async Task<CourseEnrollDTO> UpdateAsync(CourseEnroll courseEnroll)
        {
            var existingEnroll = await _context.CourseEnroll.FindAsync(courseEnroll.EnrollId);
            if (existingEnroll == null)
                throw new Exception($"CourseEnroll with ID {courseEnroll.EnrollId} not found.");

            existingEnroll.MemberId = courseEnroll.MemberId;
            existingEnroll.CourseId = courseEnroll.CourseId;
            existingEnroll.Status = courseEnroll.Status;
            existingEnroll.EnrollDate = courseEnroll.EnrollDate;
            existingEnroll.CompleteDate = courseEnroll.CompleteDate;

            await _context.SaveChangesAsync();
            return new CourseEnrollDTO
            {
                EnrollId = existingEnroll.EnrollId,
                MemberId = existingEnroll.MemberId,
                CourseId = existingEnroll.CourseId,
                Status = existingEnroll.Status,
                EnrollDate = existingEnroll.EnrollDate,
                CompleteDate = existingEnroll.CompleteDate
            };
        }

        public async Task<bool> DeleteAsync(string enrollId)
        {
            var courseEnroll = await _context.CourseEnroll.FindAsync(enrollId);
            if (courseEnroll == null)
                return false;

            _context.CourseEnroll.Remove(courseEnroll);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}