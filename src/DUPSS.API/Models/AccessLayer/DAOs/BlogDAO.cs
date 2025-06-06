using Microsoft.EntityFrameworkCore;
using DUPSS.API.Models.Objects;
using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class BlogDAO : IBlogDAO
    {
        private readonly AppDbContext _context;

        public BlogDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Blog> CreateAsync(Blog blog)
        {
            _context.Blog.Add(blog);
            await _context.SaveChangesAsync();
            return blog;
        }

        public async Task<Blog> GetByIdAsync(string blogId)
        {
            return await _context.Blog
                .Include(b => b.Staff)
                .FirstOrDefaultAsync(b => b.BlogId == blogId);
        }

        public async Task<List<Blog>> GetAllAsync()
        {
            return await _context.Blog
                .Include(b => b.Staff)
                .ToListAsync();
        }

        public async Task<Blog> UpdateAsync(Blog blog)
        {
            _context.Blog.Update(blog);
            await _context.SaveChangesAsync();
            return blog;
        }

        public async Task<bool> DeleteAsync(string blogId)
        {
            var blog = await _context.Blog.FindAsync(blogId);
            if (blog == null)
                return false;

            _context.Blog.Remove(blog);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
