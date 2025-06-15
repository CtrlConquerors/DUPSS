using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using System;
using System.Runtime.CompilerServices;

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
                .Include(ce => ce.Member) // Eagerly load Member
                .Include(ce => ce.Course) // Eagerly load Course
                    .ThenInclude(c => c.Topic) // Then include Topic of the Course
                .Include(ce => ce.Course) // Re-include Course to chain for Staff
                    .ThenInclude(c => c.Staff) // Then include Staff of the Course
                .Include(ce => ce.Course) // Re-include Course to chain for Consultant
                    .ThenInclude(c => c.Consultant) // NEW: Then include Consultant of the Course
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
                        Description = ce.Course.Description, // NEW: Include Description
                        ConsultantId = ce.Course.ConsultantId, // NEW: Include ConsultantId
                        ImageUrl = $"images/{ce.Course.CourseId}.jpg",
                        CreatedDate = ce.Course.CreatedDate,
                        Status = ce.Course.Status,
                        Inventory = ce.Course.Inventory,
                        IsSelected = ce.Course.IsSelected,
                        Topic = ce.Course.Topic != null ? new CourseTopicDTO
                        {
                            TopicId = ce.Course.Topic.TopicId,
                            TopicName = ce.Course.Topic.TopicName
                        } : null,
                        Staff = ce.Course.Staff != null ? new UserDTO
                        {
                            UserId = ce.Course.Staff.UserId,
                            Username = ce.Course.Staff.Username,
                            DoB = ce.Course.Staff.DoB,
                            PhoneNumber = ce.Course.Staff.PhoneNumber,
                            Email = ce.Course.Staff.Email,
                            RoleId = ce.Course.Staff.RoleId
                        } : null,
                        Consultant = ce.Course.Consultant != null ? new UserDTO // NEW: Include Consultant DTO
                        {
                            UserId = ce.Course.Consultant.UserId,
                            Username = ce.Course.Consultant.Username,
                            DoB = ce.Course.Consultant.DoB,
                            PhoneNumber = ce.Course.Consultant.PhoneNumber,
                            Email = ce.Course.Consultant.Email,
                            RoleId = ce.Course.Consultant.RoleId
                        } : null
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<CourseEnrollDTO>> GetAllAsync()
        {
            return await _context.CourseEnroll
                .Include(ce => ce.Member) // Eagerly load Member
                .Include(ce => ce.Course) // Eagerly load Course
                    .ThenInclude(c => c.Topic) // Then include Topic of the Course
                .Include(ce => ce.Course) // Re-include Course to chain for Staff
                    .ThenInclude(c => c.Staff) // Then include Staff of the Course
                .Include(ce => ce.Course) // Re-include Course to chain for Consultant
                    .ThenInclude(c => c.Consultant) // NEW: Then include Consultant of the Course
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
                        Description = ce.Course.Description, // NEW: Include Description
                        ConsultantId = ce.Course.ConsultantId, // NEW: Include ConsultantId
                        ImageUrl = $"images/{ce.Course.CourseId}.jpg",
                        CreatedDate = ce.Course.CreatedDate,
                        Status = ce.Course.Status,
                        Inventory = ce.Course.Inventory,
                        IsSelected = ce.Course.IsSelected,
                        Topic = ce.Course.Topic != null ? new CourseTopicDTO
                        {
                            TopicId = ce.Course.Topic.TopicId,
                            TopicName = ce.Course.Topic.TopicName
                        } : null,
                        Staff = ce.Course.Staff != null ? new UserDTO
                        {
                            UserId = ce.Course.Staff.UserId,
                            Username = ce.Course.Staff.Username,
                            DoB = ce.Course.Staff.DoB,
                            PhoneNumber = ce.Course.Staff.PhoneNumber,
                            Email = ce.Course.Staff.Email,
                            RoleId = ce.Course.Staff.RoleId
                        } : null,
                        Consultant = ce.Course.Consultant != null ? new UserDTO // NEW: Include Consultant DTO
                        {
                            UserId = ce.Course.Consultant.UserId,
                            Username = ce.Course.Consultant.Username,
                            DoB = ce.Course.Consultant.DoB,
                            PhoneNumber = ce.Course.Consultant.PhoneNumber,
                            Email = ce.Course.Consultant.Email,
                            RoleId = ce.Course.Consultant.RoleId
                        } : null
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
