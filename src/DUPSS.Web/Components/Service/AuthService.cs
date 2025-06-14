using DUPSS.API.Models.Common;

namespace DUPSS.Web.Components.Service
{
    public class AuthService
    {
        private readonly HttpClient _httpClient;
        private readonly CustomJwtAuthStateProvider _authStateProvider;
        private readonly JwtStorageService _jwtStorageService;
        private readonly CircuitContext _circuitContext;

        public AuthService(HttpClient httpClient, CustomJwtAuthStateProvider authStateProvider, JwtStorageService jwtStorageService, CircuitContext circuitContext)
        {
            _httpClient = httpClient;
            _authStateProvider = authStateProvider;
            _jwtStorageService = jwtStorageService;
            _circuitContext = circuitContext;
        }

        public async Task<bool> LoginAsync(string email, string password)
        {
            LoginRequest request = new LoginRequest
            {
                Email = email,
                Password = password
            };
            var response = await _httpClient.PostAsJsonAsync("api/Users/Login", request);
            if (response.IsSuccessStatusCode)
            {
                var result = await response.Content.ReadFromJsonAsync<LoginResponse>();
                _authStateProvider.SetToken(result.Token);
                return true;
            }
            return false;
        }

        public void Logout()
        {
            _authStateProvider.ClearToken();
        }

        public string? GetToken()
        {
            var circuitId = _circuitContext.CircuitId;
            return circuitId != null ? _jwtStorageService.GetJwt(circuitId) : null;
        }
    }
}
