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
                return new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));
            }

            var claims = ParseClaimsFromJwt(_accessToken);
            var identity = new ClaimsIdentity(claims, "jwt");
            var principal = new ClaimsPrincipal(identity);
            return new AuthenticationState(principal);
        }

        public async Task LoginAsync(string email, string password)
        {
            var tokenResponse = await _authApiService.LoginAsync(email, password);
            _accessToken = tokenResponse.AccessToken;
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
