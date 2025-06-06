using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class CourseTopicDAO : ICourseTopicDAO
    {
        private readonly AppDbContext _context;

        public CourseTopicDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<CourseTopic> CreateAsync(CourseTopic courseTopic)
        {
            _context.CourseTopic.Add(courseTopic);
            await _context.SaveChangesAsync();
            return courseTopic;
        }

        public async Task<CourseTopic> GetByIdAsync(string topicId)
        {
            return await _context.CourseTopic
                .Include(ct => ct.Courses)
                .FirstOrDefaultAsync(ct => ct.TopicId == topicId);
        }

        public async Task<List<CourseTopic>> GetAllAsync()
        {
            return await _context.CourseTopic
                .Include(ct => ct.Courses)
                .ToListAsync();
        }

        public async Task<CourseTopic> UpdateAsync(CourseTopic courseTopic)
        {
            _context.CourseTopic.Update(courseTopic);
            await _context.SaveChangesAsync();
            return courseTopic;
        }

        public async Task<bool> DeleteAsync(string topicId)
        {
            var courseTopic = await _context.CourseTopic.FindAsync(topicId);
            if (courseTopic == null)
                return false;

            _context.CourseTopic.Remove(courseTopic);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
