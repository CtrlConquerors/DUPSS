using DUPSS.Object;
using DUPSS.AccessLayer.DAOs;
using DUPSS.AccessLayer.Interfaces;
using Microsoft.EntityFrameworkCore;
using DUPSS.Web.Components;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));


// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

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

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();


app.UseAntiforgery();

app.MapStaticAssets();
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
