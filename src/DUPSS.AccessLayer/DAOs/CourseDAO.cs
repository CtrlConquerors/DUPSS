using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic; // Added for List<T>
using System.Linq; // Added for Select

namespace DUPSS.AccessLayer.DAOs
{
    public class CourseDAO : ICourseDAO
    {
        private readonly AppDbContext _context;

        public CourseDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Course> CreateAsync(Course course)
        {
            _context.Course.Add(course);
            await _context.SaveChangesAsync();
            return course;
        }

        public async Task<Course> GetByIdAsync(string courseId)
        {
            var course = await _context.Course
                .Include(c => c.Topic)
                .Include(c => c.Staff)
                .Include(c => c.Enrollments)
                .FirstOrDefaultAsync(c => c.CourseId == courseId);

            // Dynamically set ImageUrl if the course is found
            if (course != null)
            {
                course.ImageUrl = $"images/{course.CourseId}.jpg";
            }

            return course;
        }

        public async Task<List<Course>> GetAllAsync()
        {
            var courses = await _context.Course
                .Include(c => c.Topic)
                .Include(c => c.Staff)
                .Include(c => c.Enrollments)
                .ToListAsync();

            // Dynamically set ImageUrl for each course in the list
            foreach (var course in courses)
            {
                course.ImageUrl = $"images/{course.CourseId}.jpg";
            }

            return courses;
        }

        public async Task<Course> UpdateAsync(Course course)
        {
            // When updating, we assume ImageUrl is not stored in DB,
            // so we don't need to explicitly handle it here for persistence.
            // The ImageUrl will be dynamically set again when retrieved.
            _context.Course.Update(course);
            await _context.SaveChangesAsync();
            return course;
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