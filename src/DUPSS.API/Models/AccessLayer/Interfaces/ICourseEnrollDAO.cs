using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface ICourseEnrollDAO
    {
        Task<CourseEnroll> CreateAsync(CourseEnroll courseEnroll);
        Task<CourseEnroll> GetByIdAsync(string enrollId);
        Task<List<CourseEnroll>> GetAllAsync();
        Task<CourseEnroll> UpdateAsync(CourseEnroll courseEnroll);
        Task<bool> DeleteAsync(string enrollId);
    }
}
