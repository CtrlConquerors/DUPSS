using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class AppointmentDAO : IAppointmentDAO
    {
        private readonly AppDbContext _context;

        public AppointmentDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<Appointment> CreateAsync(Appointment appointment)
        {
            _context.Appointment.Add(appointment);
            await _context.SaveChangesAsync();
            return appointment;
        }

        public async Task<Appointment> GetByIdAsync(string appointmentId)
        {
            return await _context.Appointment
                .Include(a => a.Member)
                .Include(a => a.Consultant)
                .FirstOrDefaultAsync(a => a.AppointmentId == appointmentId);
        }

        public async Task<List<Appointment>> GetAllAsync()
        {
            return await _context.Appointment
                .Include(a => a.Member)
                .Include(a => a.Consultant)
                .ToListAsync();
        }

        public async Task<Appointment> UpdateAsync(Appointment appointment)
        {
            _context.Appointment.Update(appointment);
            await _context.SaveChangesAsync();
            return appointment;
        }

        public async Task<bool> DeleteAsync(string appointmentId)
        {
            var appointment = await _context.Appointment.FindAsync(appointmentId);
            if (appointment == null)
                return false;

            _context.Appointment.Remove(appointment);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
