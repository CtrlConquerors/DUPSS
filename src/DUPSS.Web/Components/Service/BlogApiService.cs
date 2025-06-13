using DUPSS.API.Models.Objects;

namespace DUPSS.Web.Components.Service
{
    public class BlogApiService : GenericApiService<Blog>
    {
        public BlogApiService(HttpClient httpClient)
            : base(httpClient, "api/Blogs")
        {
        }
    }
}
