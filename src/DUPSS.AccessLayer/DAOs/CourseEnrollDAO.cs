using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    public class CourseEnrollDAO : ICourseEnrollDAO
    {
        private readonly AppDbContext _context;

        public CourseEnrollDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<CourseEnroll> CreateAsync(CourseEnroll courseEnroll)
        {
            _context.CourseEnrollment.Add(courseEnroll);
            await _context.SaveChangesAsync();
            return courseEnroll;
        }

        public async Task<CourseEnroll> GetByIdAsync(string enrollId)
        {
            return await _context.CourseEnrollment
                .Include(ce => ce.Member)
                .Include(ce => ce.Course)
                .FirstOrDefaultAsync(ce => ce.EnrollId == enrollId);
        }

        public async Task<List<CourseEnroll>> GetAllAsync()
        {
            return await _context.CourseEnrollment
                .Include(ce => ce.Member)
                .Include(ce => ce.Course)
                .ToListAsync();
        }

        public async Task<CourseEnroll> UpdateAsync(CourseEnroll courseEnroll)
        {
            _context.CourseEnrollment.Update(courseEnroll);
            await _context.SaveChangesAsync();
            return courseEnroll;
        }

        public async Task<bool> DeleteAsync(string enrollId)
        {
            var courseEnroll = await _context.CourseEnrollment.FindAsync(enrollId);
            if (courseEnroll == null)
                return false;

            _context.CourseEnrollment.Remove(courseEnroll);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
