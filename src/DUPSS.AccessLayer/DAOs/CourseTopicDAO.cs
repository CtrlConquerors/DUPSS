using DUPSS.Object;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.AccessLayer.DAOs
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
            _context.CourseTopics.Add(courseTopic);
            await _context.SaveChangesAsync();
            return courseTopic;
        }

        public async Task<CourseTopic> GetByIdAsync(string topicId)
        {
            return await _context.CourseTopics
                .Include(ct => ct.Courses)
                .FirstOrDefaultAsync(ct => ct.TopicId == topicId);
        }

        public async Task<List<CourseTopic>> GetAllAsync()
        {
            return await _context.CourseTopics
                .Include(ct => ct.Courses)
                .ToListAsync();
        }

        public async Task<CourseTopic> UpdateAsync(CourseTopic courseTopic)
        {
            _context.CourseTopics.Update(courseTopic);
            await _context.SaveChangesAsync();
            return courseTopic;
        }

        public async Task<bool> DeleteAsync(string topicId)
        {
            var courseTopic = await _context.CourseTopics.FindAsync(topicId);
            if (courseTopic == null)
                return false;

            _context.CourseTopics.Remove(courseTopic);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
