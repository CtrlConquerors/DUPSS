using Microsoft.AspNetCore.Components.Authorization;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace DUPSS.Web.Components.Service
{
    public class CustomJwtAuthStateProvider : AuthenticationStateProvider
    {
        private readonly JwtStorageService _jwtStorageService;
        private readonly CircuitContext _circuitContext;

        public CustomJwtAuthStateProvider(JwtStorageService jwtStorageService, CircuitContext circuitContext)
        {
            _jwtStorageService = jwtStorageService;
            _circuitContext = circuitContext;
        }

        public void SetToken(string jwt)
        {
            var circuitId = _circuitContext.CircuitId ?? throw new InvalidOperationException("No circuit ID available.");
            _jwtStorageService.StoreJwt(circuitId, jwt);
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public void ClearToken()
        {
            var circuitId = _circuitContext.CircuitId;
            if (!string.IsNullOrEmpty(circuitId))
            {
                _jwtStorageService.RemoveJwt(circuitId);
            }
            NotifyAuthenticationStateChanged(GetAuthenticationStateAsync());
        }

        public override Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            var circuitId = _circuitContext.CircuitId;
            if (string.IsNullOrEmpty(circuitId))
            {
                return Task.FromResult(new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity())));
            }

            var jwt = _jwtStorageService.GetJwt(circuitId);
            if (string.IsNullOrEmpty(jwt))
            {
                return Task.FromResult(new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity())));
            }

            try
            {
                var handler = new JwtSecurityTokenHandler();
                var jwtToken = handler.ReadJwtToken(jwt);
                var identity = new ClaimsIdentity(jwtToken.Claims, "jwt");
                var principal = new ClaimsPrincipal(identity);
                return Task.FromResult(new AuthenticationState(principal));
            }
            catch
            {
                return Task.FromResult(new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity())));
            }
        }
    }
}
