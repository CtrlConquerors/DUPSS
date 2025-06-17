using Microsoft.AspNetCore.Components.Authorization;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace DUPSS.Web.Components.Service
{
    public class JwtAuthenticationStateProvider : AuthenticationStateProvider
    {
        private readonly AuthApiService _authApiService;
        private string? _accessToken;

        public JwtAuthenticationStateProvider(AuthApiService authApiService)
        {
            _authApiService = authApiService;
        }

        public override async Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            if (string.IsNullOrEmpty(_accessToken))
            {
                Console.WriteLine("No access token, returning unauthenticated state");
                return new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));
            }

            var claims = ParseClaimsFromJwt(_accessToken);
            if (!claims.Any())
            {
                Console.WriteLine("No claims parsed from JWT");
                return new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));
            }
            Console.WriteLine($"Parsed claims: {string.Join(", ", claims.Select(c => $"{c.Type}={c.Value}"))}");
            var identity = new ClaimsIdentity(claims, "jwt");
            var principal = new ClaimsPrincipal(identity);
            return new AuthenticationState(principal);
        }

        public async Task LoginAsync(string email, string password)
        {
            Console.WriteLine($"Calling AuthApiService.LoginAsync with email: {email}");
            var tokenResponse = await _authApiService.LoginAsync(email, password);
            if (tokenResponse == null)
            {
                Console.WriteLine("Login failed: TokenResponse is null");
                throw new Exception("Invalid email or password.");
            }
            _accessToken = tokenResponse.AccessToken;
            Console.WriteLine("Login successful, notifying authentication state change");
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public void Logout()
        {
            _accessToken = null;
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public string? GetAccessToken() => _accessToken;

        private IEnumerable<Claim> ParseClaimsFromJwt(string jwt)
        {
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(jwt) as JwtSecurityToken;
            return jsonToken?.Claims ?? Enumerable.Empty<Claim>();
        }
    }
}
