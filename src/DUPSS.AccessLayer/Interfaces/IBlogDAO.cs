using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
{
    public interface IBlogDAO
    {
        Task<Blog> CreateAsync(Blog blog);
        Task<Blog> GetByIdAsync(string blogId);
        Task<List<Blog>> GetAllAsync();
        Task<Blog> UpdateAsync(Blog blog);
        Task<bool> DeleteAsync(string blogId);
    }
}
