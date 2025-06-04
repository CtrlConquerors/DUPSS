using DUPSS.AccessLayer.DAOs;
using DUPSS.AccessLayer.Interfaces;
using DUPSS.Object;
using DUPSS.Web.Components;
using DUPSS.Web.Components.Service;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Supabase;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add DbContext
builder.Services.AddDbContextFactory<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// Add services to the container
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents(options =>
    {
        options.DetailedErrors = true;
    });

// Add Supabase client
var supabaseUrl = builder.Configuration["Supabase:Url"]!;
var supabaseKey = builder.Configuration["Supabase:AnonKey"]!;
builder.Services.AddSingleton<Client>(sp => new Client(supabaseUrl, supabaseKey));

// Add authentication services
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = builder.Configuration["Supabase:Url"],
        ValidAudience = "authenticated",
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Supabase:JwtSecret"]!))
    };
});

// Add authorization services
builder.Services.AddAuthorizationCore();

// Add DAOs
builder.Services.AddScoped<IRoleDAO, RoleDAO>();
builder.Services.AddScoped<IUserDAO, UserDAO>();
builder.Services.AddScoped<IAppointmentDAO, AppointmentDAO>();
builder.Services.AddScoped<ICampaignDAO, CampaignDAO>();
builder.Services.AddScoped<ICourseTopicDAO, CourseTopicDAO>();
builder.Services.AddScoped<ICourseDAO, CourseDAO>();
builder.Services.AddScoped<ICourseEnrollDAO, CourseEnrollDAO>();
builder.Services.AddScoped<IAssessmentDAO, AssessmentDAO>();
builder.Services.AddScoped<IAssessmentResultDAO, AssessmentResultDAO>();
builder.Services.AddScoped<IBlogDAO, BlogDAO>();

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<AuthenticationStateProvider, CustomAuthStateProvider>();

var app = builder.Build();

try
{
    var supabase = app.Services.GetRequiredService<Supabase.Client>();
    await supabase.InitializeAsync();
    Console.WriteLine("Supabase client initialized successfully.");
}
catch (Exception ex)
{
    Console.WriteLine($"Supabase initialization failed: {ex.Message}");
}

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles(); // Ensure static files are served
app.UseAntiforgery();
app.UseAuthentication();
app.UseAuthorization();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();