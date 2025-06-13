using DUPSS.API.Models.Objects;
namespace DUPSS.Web.Components.Service
{
    public class AppointmentApiService : GenericApiService<Appointment>
    {
        public AppointmentApiService(HttpClient httpClient)
            : base(httpClient, "api/Appointments")
        {
        }
    }
}
