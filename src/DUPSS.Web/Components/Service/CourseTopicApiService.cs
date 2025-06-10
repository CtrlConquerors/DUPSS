using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class CourseTopicApiService : GenericApiService<CourseTopic>
    {
        public CourseTopicApiService(HttpClient httpClient)
            : base(httpClient, "api/CourseTopics")
        {
        }
    }
}
