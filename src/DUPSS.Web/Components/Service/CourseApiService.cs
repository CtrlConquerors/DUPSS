using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CourseApiService : GenericApiService<Course>
    {
        public CourseApiService(HttpClient httpClient)
            : base(httpClient, "api/Courses")
        {
        }
    }
}
