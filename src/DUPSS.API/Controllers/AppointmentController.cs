using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.AspNetCore.Mvc;

namespace DUPSS.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AppointmentController : ControllerBase
    {
        private readonly AppointmentDAO _appointmentDAO;

        public AppointmentController(AppDbContext context)
        {
            _appointmentDAO = new AppointmentDAO(context);
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<AppointmentDTO>>> GetAll()
        {
            try
            {
                var appointments = await _appointmentDAO.GetAllAsync();
                return Ok(appointments);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetById/{appointmentId}")]
        public async Task<ActionResult<AppointmentDTO>> GetById(string appointmentId)
        {
            try
            {
                var appointment = await _appointmentDAO.GetByIdAsync(appointmentId);
                if (appointment == null)
                    return NotFound($"Appointment with ID {appointmentId} not found.");
                return Ok(appointment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("Create")]
        public async Task<ActionResult<AppointmentDTO>> Create([FromBody] Appointment appointment)
        {
            try
            {
                var createdAppointment = await _appointmentDAO.CreateAsync(appointment);
                return CreatedAtAction(nameof(GetById), new { appointmentId = createdAppointment.AppointmentId }, createdAppointment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPut("Update")]
        public async Task<ActionResult<AppointmentDTO>> Update([FromBody] Appointment appointment)
        {
            try
            {
                var updatedAppointment = await _appointmentDAO.UpdateAsync(appointment);
                return Ok(updatedAppointment);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpDelete("Delete/{appointmentId}")]
        public async Task<ActionResult<bool>> Delete(string appointmentId)
        {
            try
            {
                var result = await _appointmentDAO.DeleteAsync(appointmentId);
                if (!result)
                    return NotFound($"Appointment with ID {appointmentId} not found.");
                return Ok(result);
            }
            catch (Npgsql.NpgsqlException ex)
            {
                return StatusCode(500, $"Database error: {ex.Message}");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}