using Microsoft.EntityFrameworkCore;
using System.Collections.Generic; // Added for List<T>
using System.Linq;
using DUPSS.API.Models.Objects;
using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;

namespace DUPSS.API.Models.AccessLayer.DAOs
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
            // 1. Find the existing course in the database
            var existingCourse = await _context.Course.FindAsync(course.CourseId);

            if (existingCourse == null)
            {
                // If the course doesn't exist, throw an exception or handle appropriately
                throw new Exception($"Course with ID {course.CourseId} not found for update.");
            }

            // 2. Update the properties of the existing entity with the new values
            //    Only update the properties that are actually stored in the database.
            //    Do NOT assign NotMapped properties like ImageUrl, CreatedDate, Status, Inventory, IsSelected here.
            existingCourse.CourseName = course.CourseName;
            existingCourse.CourseType = course.CourseType;
            existingCourse.TopicId = course.TopicId;
            existingCourse.StaffId = course.StaffId;

            // 3. Mark the entity as modified (if not already done by property assignment)
            //    _context.Entry(existingCourse).State = EntityState.Modified; // Often not needed if properties are changed directly

            // 4. Save the changes to the database
            await _context.SaveChangesAsync();

            // 5. Return the updated existingCourse (which now has the latest data)
            return existingCourse;
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
