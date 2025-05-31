using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    public class UserDAO : IUserDAO
    {
        private readonly AppDbContext _context;

        public UserDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<User> CreateAsync(User user)
        {
            _context.User.Add(user);
            await _context.SaveChangesAsync();
            return user;
        }

        public async Task<User> GetByIdAsync(string userId)
        {
            return await _context.User
                .Include(u => u.Role)
                .Include(u => u.MemberAppointments)
                .Include(u => u.ConsultantAppointments)
                .Include(u => u.Campaigns)
                .Include(u => u.Courses)
                .Include(u => u.Enrollments)
                .Include(u => u.AssessmentResults)
                .Include(u => u.Blogs)
                .FirstOrDefaultAsync(u => u.UserId == userId);
        }

        public async Task<List<User>> GetAllAsync()
        {
            return await _context.User
                .Include(u => u.Role)
                .Include(u => u.MemberAppointments)
                .Include(u => u.ConsultantAppointments)
                .Include(u => u.Campaigns)
                .Include(u => u.Courses)
                .Include(u => u.Enrollments)
                .Include(u => u.AssessmentResults)
                .Include(u => u.Blogs)
                .ToListAsync();
        }

        public async Task<User> UpdateAsync(User user)
        {
            _context.User.Update(user);
            await _context.SaveChangesAsync();
            return user;
        }

        public async Task<bool> DeleteAsync(string userId)
        {
            var user = await _context.User.FindAsync(userId);
            if (user == null)
                return false;

            _context.User.Remove(user);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}