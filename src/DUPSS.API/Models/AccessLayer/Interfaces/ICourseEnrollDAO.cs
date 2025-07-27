using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using System.Collections.Generic; 
using System.Threading.Tasks; 

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface ICourseEnrollDAO
    {
        Task<CourseEnrollDTO> CreateAsync(CourseEnroll courseEnroll);
        Task<CourseEnrollDTO?> GetByIdAsync(string enrollId);
        Task<List<CourseEnrollDTO>> GetAllAsync();
        Task<CourseEnrollDTO> UpdateAsync(CourseEnroll courseEnroll);
        Task<bool> DeleteAsync(string enrollId);
       
        Task<List<CourseEnrollDTO>?> GetEnrollmentsByMemberAndCourse(string memberId, string courseId);
    }
}
