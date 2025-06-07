using DUPSS.API.Models.AccessLayer;
using DUPSS.API.Models.AccessLayer.DAOs;
using DUPSS.API.Models.AccessLayer.Interfaces;
using DUPSS.API.Models.Objects;
using DUPSS.API.Service;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Supabase;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
// Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
builder.Services.AddOpenApi();

// Add DbContext
builder.Services.AddDbContextFactory<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// Add services to the container
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents(options =>
    {
        options.DetailedErrors = true;
    });

builder.Services.AddHttpClient();

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

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowBlazor", builder =>
        builder.WithOrigins("https://localhost:7084")
               .AllowAnyMethod()
               .AllowAnyHeader()
               .AllowCredentials());
});

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

app.UseCors("AllowBlazor");

app.MapOpenApi();
app.UseSwagger();
app.UseSwaggerUI();
app.UseHttpsRedirection();
app.UseAntiforgery();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();



app.Run();