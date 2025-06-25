using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class AssessmentQuestionDAO : IAssessmentQuestionDAO
    {
        private readonly AppDbContext _context;

        public AssessmentQuestionDAO(AppDbContext context)
        {
            _context = context;
        }
        public async Task<AssessmentQuestionDTO> CreateAsync(AssessmentQuestion question)
        {
            question.QuestionId = Guid.NewGuid().ToString();
            _context.AssessmentQuestion.Add(question);
            await _context.SaveChangesAsync();
            return new AssessmentQuestionDTO
            {
                QuestionId = question.QuestionId,
                AssessmentId = question.AssessmentId,
                Question = question.Question,
                QuestionType = question.QuestionType,
                Answers = new List<AssessmentAnswerDTO>()
            };
        }
        public async Task<IEnumerable<AssessmentQuestionDTO>> GetByIdAsync(string assessmentId, bool includeAnswers)
        {
            var query = _context.AssessmentQuestion
                .Where(q => q.AssessmentId == assessmentId)
                .AsQueryable();

            if (includeAnswers)
                query = query.Include(q => q.Answers);

            var questions = await query.ToListAsync();
            return questions.Select(q => new AssessmentQuestionDTO
            {
                QuestionId = q.QuestionId,
                AssessmentId = q.AssessmentId,
                Question = q.Question,
                QuestionType = q.QuestionType,
                Answers = includeAnswers && q.Answers != null
                    ? q.Answers.Select(a => new AssessmentAnswerDTO
                    {
                        AnswerId = a.AnswerId,
                        QuestionId = a.QuestionId,
                        Answer = a.Answer,
                        ScoreValue = a.ScoreValue,
                        ScoreDescription = a.ScoreDescription
                    }).ToList()
                    : new List<AssessmentAnswerDTO>()
            });
        }

        public async Task<AssessmentQuestionDTO> UpdateAsync(AssessmentQuestion question)
        {
            var existingQuestion = await _context.AssessmentQuestion.FindAsync(question.QuestionId);
            if (existingQuestion == null)
                return null;

            existingQuestion.AssessmentId = question.AssessmentId;
            existingQuestion.Question = question.Question;
            existingQuestion.QuestionType = question.QuestionType;
            await _context.SaveChangesAsync();
            return new AssessmentQuestionDTO
            {
                QuestionId = existingQuestion.QuestionId,
                AssessmentId = existingQuestion.AssessmentId,
                Question = existingQuestion.Question,
                QuestionType = existingQuestion.QuestionType,
                Answers = new List<AssessmentAnswerDTO>()
            };
        }

        public async Task<bool> DeleteAsync(string questionId)
        {
            var question = await _context.AssessmentQuestion.FindAsync(questionId);
            if (question == null)
                return false;

            _context.AssessmentQuestion.Remove(question);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}