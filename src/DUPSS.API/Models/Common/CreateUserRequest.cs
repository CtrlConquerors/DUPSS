using DUPSS.API.Models.Objects;

namespace DUPSS.API.Models.Common
{
    public class CreateUserRequest
    {
        public required User User { get; set; }
        public required string Password { get; set; }
    }
}
