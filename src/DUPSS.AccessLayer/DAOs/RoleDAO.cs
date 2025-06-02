using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
{
    public class RoleDAO : IRoleDAO
    {
        private readonly AppDbContext _context;

        public RoleDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Role> CreateAsync(Role role)
        {
            _context.Role.Add(role);
            await _context.SaveChangesAsync();
            return role;
        }

        public async Task<Role> GetByIdAsync(string roleId)
        {
            return await _context.Role
                .Include(r => r.Users)
                .FirstOrDefaultAsync(r => r.RoleId == roleId);
        }

        public async Task<List<Role>> GetAllAsync()
        {
            return await _context.Role
                .Include(r => r.Users)
                .ToListAsync();
        }

        public async Task<Role> UpdateAsync(Role role)
        {
            _context.Role.Update(role);
            await _context.SaveChangesAsync();
            return role;
        }

        public async Task<bool> DeleteAsync(string roleId)
        {
            var role = await _context.Role.FindAsync(roleId);
            if (role == null)
                return false;

            _context.Role.Remove(role);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
