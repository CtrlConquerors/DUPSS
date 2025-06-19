// using Microsoft.AspNetCore.Components.Authentication;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Threading;

namespace DUPSS.Web.Components.Service
{
    public class JwtAuthenticationStateProvider : AuthenticationStateProvider
    {
        private readonly AuthApiService _authApiService;
        private readonly ProtectedSessionStorage _sessionStorage;
        private const string AccessTokenKey = "accessToken";
        private string? _accessToken;
        private System.Threading.Timer? _logoutTimer;

        public JwtAuthenticationStateProvider(AuthApiService authApiService, ProtectedSessionStorage sessionStorage)
        {
            _authApiService = authApiService;
            _sessionStorage = sessionStorage;
        }

        public override async Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            if (string.IsNullOrEmpty(_accessToken))
            {
                try
                {
                    var result = await _sessionStorage.GetAsync<string>(AccessTokenKey);
                    _accessToken = result.Success ? result.Value : null;

                    if (!string.IsNullOrEmpty(_accessToken))
                    {
                        SetLogoutTimer(_accessToken);
                    }
                }
                catch (InvalidOperationException ex)
                {
                    // JS interop not available (likely during prerendering)
                    Console.WriteLine($"JS interop unavailable: {ex.Message}");
                    return new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));
                }
            }
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
            await _sessionStorage.SetAsync(AccessTokenKey, _accessToken);
            SetLogoutTimer(_accessToken);
            Console.WriteLine("Login successful, notifying authentication state change");
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public async Task Logout()
        {
            _accessToken = null;
            _logoutTimer?.Dispose();
            await _sessionStorage.DeleteAsync(AccessTokenKey);
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public string? GetAccessToken() => _accessToken;

        private IEnumerable<Claim> ParseClaimsFromJwt(string jwt)
        {
            var handler = new JwtSecurityTokenHandler();
            var jsonToken = handler.ReadToken(jwt) as JwtSecurityToken;
            return jsonToken?.Claims ?? Enumerable.Empty<Claim>();
        }

        private void SetLogoutTimer(string jwt)
        {
            var handler = new JwtSecurityTokenHandler();
            var token = handler.ReadJwtToken(jwt);
            var expires = token.ValidTo;
            var timeToExpire = expires - DateTime.UtcNow;

            if (timeToExpire <= TimeSpan.Zero)
            {
                Logout();
                return;
            }

            _logoutTimer = new Timer(_ =>
            {
                _logoutTimer?.Dispose();
                Logout();
            }, null, timeToExpire, Timeout.InfiniteTimeSpan);
        }
    }
}
