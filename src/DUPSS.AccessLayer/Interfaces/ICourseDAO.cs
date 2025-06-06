﻿using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
{
    public interface ICourseDAO
    {
        Task<Course> CreateAsync(Course course);
        Task<Course> GetByIdAsync(string courseId);
        Task<List<Course>> GetAllAsync();
        Task<Course> UpdateAsync(Course course);
        Task<bool> DeleteAsync(string courseId);
    }
}
