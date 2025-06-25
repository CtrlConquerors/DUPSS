using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class AssessmentAnswerDAO : IAssessmentAnswerDAO
    {
        private readonly AppDbContext _context;

        public AssessmentAnswerDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<AssessmentAnswerDTO>> GetByIdAsync(string questionId)
        {
            var answers = await _context.AssessmentAnswer
                .Where(a => a.QuestionId == questionId)
                .ToListAsync();
            return answers.Select(a => new AssessmentAnswerDTO
            {
                AnswerId = a.AnswerId,
                QuestionId = a.QuestionId,
                Answer = a.Answer,
                ScoreValue = a.ScoreValue,
                ScoreDescription = a.ScoreDescription
            });
        }

        public async Task<AssessmentAnswerDTO> CreateAsync(AssessmentAnswer answer)
        {
            answer.AnswerId = Guid.NewGuid().ToString();
            _context.AssessmentAnswer.Add(answer);
            await _context.SaveChangesAsync();
            return new AssessmentAnswerDTO
            {
                AnswerId = answer.AnswerId,
                QuestionId = answer.QuestionId,
                Answer = answer.Answer,
                ScoreValue = answer.ScoreValue,
                ScoreDescription = answer.ScoreDescription
            };
        }

        public async Task<AssessmentAnswerDTO> UpdateAsync(AssessmentAnswer answer)
        {
            var existingAnswer = await _context.AssessmentAnswer.FindAsync(answer.AnswerId);
            if (existingAnswer == null)
                return null;

            existingAnswer.QuestionId = answer.QuestionId;
            existingAnswer.Answer = answer.Answer;
            existingAnswer.ScoreValue = answer.ScoreValue;
            existingAnswer.ScoreDescription = answer.ScoreDescription;
            await _context.SaveChangesAsync();
            return new AssessmentAnswerDTO
            {
                AnswerId = existingAnswer.AnswerId,
                QuestionId = existingAnswer.QuestionId,
                Answer = existingAnswer.Answer,
                ScoreValue = existingAnswer.ScoreValue,
                ScoreDescription = existingAnswer.ScoreDescription
            };
        }

        public async Task<bool> DeleteAsync(string answerId)
        {
            var answer = await _context.AssessmentAnswer.FindAsync(answerId);
            if (answer == null)
                return false;

            _context.AssessmentAnswer.Remove(answer);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}