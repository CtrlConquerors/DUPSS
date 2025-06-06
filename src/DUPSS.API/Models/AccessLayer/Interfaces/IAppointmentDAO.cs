using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.AccessLayer.Interfaces
{
    public interface IAppointmentDAO
    {
        Task<Appointment> CreateAsync(Appointment appointment);
        Task<Appointment> GetByIdAsync(string appointmentId);
        Task<List<Appointment>> GetAllAsync();
        Task<Appointment> UpdateAsync(Appointment appointment);
        Task<bool> DeleteAsync(string appointmentId);
    }
}
