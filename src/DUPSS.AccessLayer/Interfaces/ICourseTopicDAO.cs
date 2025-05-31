using DUPSS.Object;

namespace DUPSS.AccessLayer.Interfaces
{
    public interface ICourseTopicDAO
    {
        Task<CourseTopic> CreateAsync(CourseTopic courseTopic);
        Task<CourseTopic> GetByIdAsync(string topicId);
        Task<List<CourseTopic>> GetAllAsync();
        Task<CourseTopic> UpdateAsync(CourseTopic courseTopic);
        Task<bool> DeleteAsync(string topicId);
    }
}
