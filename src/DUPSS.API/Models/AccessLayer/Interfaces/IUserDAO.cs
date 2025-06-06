using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IUserDAO
    {
        Task<User> CreateAsync(User user, string password);
        Task<User> GetByIdAsync(string userId);
        Task<List<User>> GetAllAsync();
        Task<User> UpdateAsync(User user);
        Task<bool> DeleteAsync(string userId);
    }
}