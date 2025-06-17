using DUPSS.Web.Components;
using DUPSS.Web.Components.Service;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.Circuits;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents(options => {
        options.DetailedErrors = true;
    });

builder.Services.AddAuthenticationCore();
builder.Services.AddAuthorizationCore();
builder.Services.AddSingleton<JwtStorageService>();
builder.Services.AddScoped<CircuitContext>();
builder.Services.AddScoped<CircuitHandler, JwtCircuitHandler>();
builder.Services.AddScoped<CustomJwtAuthStateProvider>();
builder.Services.AddScoped<AppointmentApiService>();
builder.Services.AddScoped<AuthenticationStateProvider>(sp => sp.GetRequiredService<CustomJwtAuthStateProvider>());
builder.Services.AddScoped<AuthService>(sp =>

    new AuthService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<CustomJwtAuthStateProvider>(),
    sp.GetRequiredService<JwtStorageService>(),
    sp.GetRequiredService<CircuitContext>()
    )
);
builder.Services.AddHttpContextAccessor();

// Configure a single named HttpClient for all API services
builder.Services.AddHttpClient("ApiClient", client => {
    client.BaseAddress = new Uri("https://localhost:7288/"); // Your API URL
});

// Register API services with AuthService dependency
builder.Services.AddScoped<CourseApiService>(sp => new CourseApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<CourseTopicApiService>(sp => new CourseTopicApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<RoleApiService>(sp => new RoleApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<UserApiService>(sp => new UserApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<CampaignApiService>(sp => new CampaignApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<BlogApiService>(sp => new BlogApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
builder.Services.AddScoped<AppointmentApiService>(sp => new AppointmentApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));
// NEW: Register CourseEnrollApiService
builder.Services.AddScoped<CourseEnrollApiService>(sp => new CourseEnrollApiService(
    sp.GetRequiredService<IHttpClientFactory>().CreateClient("ApiClient"),
    sp.GetRequiredService<AuthService>()));

builder.Services.AddCors(options => {
    options.AddPolicy("AllowApi", builder =>
        builder.WithOrigins("https://localhost:7288")
            .AllowAnyMethod()
            .AllowAnyHeader()
            .AllowCredentials());
});

// REMOVED: This generic HttpClient registration is likely redundant and could cause issues
// if the named "ApiClient" is intended for all API calls.
// builder.Services.AddScoped(sp => new HttpClient
// {
//     BaseAddress = new Uri("https://localhost:7084/")
// });

var app = builder.Build();

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", true);
    app.UseHsts();
}

app.UseCors("AllowApi");
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseAntiforgery();
app.UseAuthentication();
app.UseAuthorization();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
