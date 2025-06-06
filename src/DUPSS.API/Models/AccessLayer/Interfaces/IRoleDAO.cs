using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IRoleDAO
    {
        Task<Role> CreateAsync(Role role);
        Task<Role> GetByIdAsync(string roleId);
        Task<List<Role>> GetAllAsync();
        Task<Role> UpdateAsync(Role role);
        Task<bool> DeleteAsync(string roleId);
    }
}
