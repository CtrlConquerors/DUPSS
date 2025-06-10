using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.DTOs;
using DUPSS.API.Models.Objects;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace DUPSS.API.Models.AccessLayer.DAOs
{
    public class AppointmentDAO : IAppointmentDAO
    {
        private readonly AppDbContext _context;

        public AppointmentDAO(AppDbContext context)
        {
            _context = context;
        }

        public async Task<AppointmentDTO> CreateAsync(Appointment appointment)
        {
            _context.Appointment.Add(appointment);
            await _context.SaveChangesAsync();
            return new AppointmentDTO
            {
                AppointmentId = appointment.AppointmentId,
                MemberId = appointment.MemberId,
                ConsultantId = appointment.ConsultantId,
                AppointmentDate = appointment.AppointmentDate,
                Status = appointment.Status,
                Topic = appointment.Topic,
                Notes = appointment.Notes
            };
        }

        public async Task<AppointmentDTO?> GetByIdAsync(string appointmentId)
        {
            return await _context.Appointment
                .Where(a => a.AppointmentId == appointmentId)
                .Select(a => new AppointmentDTO
                {
                    AppointmentId = a.AppointmentId,
                    MemberId = a.MemberId,
                    ConsultantId = a.ConsultantId,
                    AppointmentDate = a.AppointmentDate,
                    Status = a.Status,
                    Topic = a.Topic,
                    Notes = a.Notes,
                    Member = a.Member != null ? new UserDTO
                    {
                        UserId = a.Member.UserId,
                        Username = a.Member.Username,
                        DoB = a.Member.DoB,
                        PhoneNumber = a.Member.PhoneNumber,
                        Email = a.Member.Email,
                        RoleId = a.Member.RoleId
                    } : null,
                    Consultant = a.Consultant != null ? new UserDTO
                    {
                        UserId = a.Consultant.UserId,
                        Username = a.Consultant.Username,
                        DoB = a.Consultant.DoB,
                        PhoneNumber = a.Consultant.PhoneNumber,
                        Email = a.Consultant.Email,
                        RoleId = a.Consultant.RoleId
                    } : null
                })
                .FirstOrDefaultAsync();
        }

        public async Task<List<AppointmentDTO>> GetAllAsync()
        {
            return await _context.Appointment
                .Select(a => new AppointmentDTO
                {
                    AppointmentId = a.AppointmentId,
                    MemberId = a.MemberId,
                    ConsultantId = a.ConsultantId,
                    AppointmentDate = a.AppointmentDate,
                    Status = a.Status,
                    Topic = a.Topic,
                    Notes = a.Notes,
                    Member = a.Member != null ? new UserDTO
                    {
                        UserId = a.Member.UserId,
                        Username = a.Member.Username,
                        DoB = a.Member.DoB,
                        PhoneNumber = a.Member.PhoneNumber,
                        Email = a.Member.Email,
                        RoleId = a.Member.RoleId
                    } : null,
                    Consultant = a.Consultant != null ? new UserDTO
                    {
                        UserId = a.Consultant.UserId,
                        Username = a.Consultant.Username,
                        DoB = a.Consultant.DoB,
                        PhoneNumber = a.Consultant.PhoneNumber,
                        Email = a.Consultant.Email,
                        RoleId = a.Consultant.RoleId
                    } : null
                })
                .ToListAsync();
        }

        public async Task<AppointmentDTO> UpdateAsync(Appointment appointment)
        {
            var existingAppointment = await _context.Appointment.FindAsync(appointment.AppointmentId);
            if (existingAppointment == null)
                throw new Exception($"Appointment with ID {appointment.AppointmentId} not found.");

            existingAppointment.MemberId = appointment.MemberId;
            existingAppointment.ConsultantId = appointment.ConsultantId;
            existingAppointment.AppointmentDate = appointment.AppointmentDate;
            existingAppointment.Status = appointment.Status;
            existingAppointment.Topic = appointment.Topic;
            existingAppointment.Notes = appointment.Notes;

            await _context.SaveChangesAsync();
            return new AppointmentDTO
            {
                AppointmentId = existingAppointment.AppointmentId,
                MemberId = existingAppointment.MemberId,
                ConsultantId = existingAppointment.ConsultantId,
                AppointmentDate = existingAppointment.AppointmentDate,
                Status = existingAppointment.Status,
                Topic = existingAppointment.Topic,
                Notes = existingAppointment.Notes
            };
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