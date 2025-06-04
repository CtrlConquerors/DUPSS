using DUPSS.Object;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore;
using Supabase;
using System.Security.Claims;

namespace DUPSS.Web.Components.Service
{
    public class CustomAuthStateProvider : AuthenticationStateProvider
    {
        private readonly Supabase.Client _supabaseClient;
        private readonly IDbContextFactory<AppDbContext> _contextFactory;
        private readonly AuthenticationState _anonymous = new AuthenticationState(new ClaimsPrincipal(new ClaimsIdentity()));

        public CustomAuthStateProvider(Supabase.Client supabaseClient, IDbContextFactory<AppDbContext> contextFactory)
        {
            _supabaseClient = supabaseClient;
            _contextFactory = contextFactory;
        }

        public override async Task<AuthenticationState> GetAuthenticationStateAsync()
        {
            var session = _supabaseClient.Auth.CurrentSession;
            if (session == null || session.User == null)
            {
                Console.WriteLine("GetAuthenticationStateAsync: No active session.");
                return _anonymous;
            }

            var claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, session.User.Id!),
                new Claim(ClaimTypes.Email, session.User.Email!)
            };

            await using var context = await _contextFactory.CreateDbContextAsync();
            var user = await context.User.FirstOrDefaultAsync(u => u.UserId == session.User.Id);
            if (user != null)
            {
                claims.Add(new Claim(ClaimTypes.Name, user.Username));
                claims.Add(new Claim(ClaimTypes.Role, user.RoleId));
            }

            var identity = new ClaimsIdentity(claims, "SupabaseAuth");
            var principal = new ClaimsPrincipal(identity);
            Console.WriteLine($"GetAuthenticationStateAsync: User authenticated. Name: {user?.Username ?? session.User.Email}, Role: {user?.RoleId}");
            return new AuthenticationState(principal);
        }

        public async Task UpdateAuthState(Supabase.Gotrue.Session session)
        {
            if (session == null || session.User == null)
            {
                Console.WriteLine("UpdateAuthState: No session or user, setting anonymous state.");
                NotifyAuthenticationStateChanged(Task.FromResult(_anonymous));
                return;
            }

            var claims = new List<Claim>
        {
            new Claim(ClaimTypes.NameIdentifier, session.User.Id!),
            new Claim(ClaimTypes.Email, session.User.Email!)
        };

            await using var context = await _contextFactory.CreateDbContextAsync();
            var user = await context.User.FirstOrDefaultAsync(u => u.UserId == session.User.Id);
            if (user != null)
            {
                claims.Add(new Claim(ClaimTypes.Name, user.Username));
                claims.Add(new Claim(ClaimTypes.Role, user.RoleId));
            }

            var identity = new ClaimsIdentity(claims, "SupabaseAuth");
            var principal = new ClaimsPrincipal(identity);
            Console.WriteLine($"UpdateAuthState: Notifying authentication state change. Name: {user?.Username ?? session.User.Email}, Role: {user?.RoleId}");
            NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(principal)));
        }

        public async Task SignOutAsync()
        {
            Console.WriteLine("SignOutAsync: Signing out user.");
            await _supabaseClient.Auth.SignOut();
            NotifyAuthenticationStateChanged(Task.FromResult(_anonymous));
        }
    }
}
