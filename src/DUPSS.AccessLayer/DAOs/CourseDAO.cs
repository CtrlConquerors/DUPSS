using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

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
            return await _context.Course
                .Include(c => c.Topic)
                .Include(c => c.Staff)
                .Include(c => c.Enrollments)
                .FirstOrDefaultAsync(c => c.CourseId == courseId);
        }

        public async Task<List<Course>> GetAllAsync()
        {
            return await _context.Course
                .Include(c => c.Topic)
                .Include(c => c.Staff)
                .Include(c => c.Enrollments)
                .ToListAsync();
        }

        public async Task<Course> UpdateAsync(Course course)
        {
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
