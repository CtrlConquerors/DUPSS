using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
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
            _context.Blogs.Add(blog);
            await _context.SaveChangesAsync();
            return blog;
        }

        public async Task<Blog> GetByIdAsync(string blogId)
        {
            return await _context.Blogs
                .Include(b => b.Staff)
                .FirstOrDefaultAsync(b => b.BlogId == blogId);
        }

        public async Task<List<Blog>> GetAllAsync()
        {
            return await _context.Blogs
                .Include(b => b.Staff)
                .ToListAsync();
        }

        public async Task<Blog> UpdateAsync(Blog blog)
        {
            _context.Blogs.Update(blog);
            await _context.SaveChangesAsync();
            return blog;
        }

        public async Task<bool> DeleteAsync(string blogId)
        {
            var blog = await _context.Blogs.FindAsync(blogId);
            if (blog == null)
                return false;

            _context.Blogs.Remove(blog);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
