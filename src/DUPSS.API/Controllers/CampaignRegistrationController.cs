
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CampaignRegistrationController : ControllerBase
    {
        private readonly ICampaignRegistrationDAO _dao;

        public CampaignRegistrationController(ICampaignRegistrationDAO dao)
        {
            _dao = dao;
        }

        // GET: api/CampaignRegistration
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CampaignRegistrationDTO>>> GetAll()
        {
            var registrations = await _dao.GetAllAsync();
            var result = registrations.Select(r => new CampaignRegistrationDTO
            {
                RegistrationId = r.RegistrationId,
                UserId = r.UserId,
                CampaignId = r.CampaignId,
                RegisteredAt = r.RegisteredAt
            });

            return Ok(result);
        }

        // GET: api/CampaignRegistration/user/{userId}
        [HttpGet("user/{userId}")]
        public async Task<ActionResult<IEnumerable<CampaignRegistrationDTO>>> GetByUserId(string userId)
        {
            var registrations = await _dao.GetByUserIdAsync(userId);
            var result = registrations.Select(r => new CampaignRegistrationDTO
            {
                RegistrationId = r.RegistrationId,
                UserId = r.UserId,
                CampaignId = r.CampaignId,
                RegisteredAt = r.RegisteredAt
            });

            return Ok(result);
        }

        // GET: api/CampaignRegistration/campaign/{campaignId}
        [HttpGet("campaign/{campaignId}")]
        public async Task<ActionResult<IEnumerable<CampaignRegistrationDTO>>> GetByCampaignId(string campaignId)
        {
            var registrations = await _dao.GetByCampaignIdAsync(campaignId);
            var result = registrations.Select(r => new CampaignRegistrationDTO
            {
                RegistrationId = r.RegistrationId,
                UserId = r.UserId,
                CampaignId = r.CampaignId,
                RegisteredAt = r.RegisteredAt
            });

            return Ok(result);
        }

        // POST: api/CampaignRegistration
        [HttpPost]
        public async Task<ActionResult> Register([FromBody] CampaignRegistration registration)
        {
            // Kiểm tra trùng
            if (await _dao.ExistsAsync(registration.UserId, registration.CampaignId))
            {
                return Conflict("User already registered for this campaign.");
            }

            registration.RegistrationId = Guid.NewGuid().ToString();
            registration.RegisteredAt = DateTime.UtcNow;

            await _dao.AddAsync(registration);

            return CreatedAtAction(nameof(GetByUserId), new { userId = registration.UserId }, registration);
        }

        // DELETE: api/CampaignRegistration/{id}
        [HttpDelete("{id}")]
        public async Task<ActionResult> Delete(string id)
        {
            var existing = await _dao.GetByIdAsync(id);
            if (existing == null)
                return NotFound();

            await _dao.DeleteAsync(id);
            return NoContent();
        }
    }
}
