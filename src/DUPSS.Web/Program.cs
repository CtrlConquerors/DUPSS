using DUPSS.Web.Components;
using DUPSS.Web.Components.Service;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents(options => {
        options.DetailedErrors = true;
    });

builder.Services.AddHttpClient<CourseApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<CourseTopicApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<RoleApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<UserApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<CampaignApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<BlogApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});
builder.Services.AddHttpClient<AppointmentApiService>(client => {
    client.BaseAddress = new Uri("https://localhost:7288/");
});

builder.Services.AddHttpContextAccessor();

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
    app.UseExceptionHandler("/Error", true);
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles(); // Ensure static files are served
app.UseAntiforgery();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();
