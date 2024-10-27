using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Domain.Extension;
using Pms.Domain.DbContex;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddServerSideBlazor().AddCircuitOptions(options =>
{
    options.DisconnectedCircuitMaxRetained = 100;
    options.DisconnectedCircuitRetentionPeriod = TimeSpan.FromMinutes(3);
    options.JSInteropDefaultCallTimeout = TimeSpan.FromMinutes(1);
});

 
builder.Services.AddLogging(builder => builder
    .AddFilter("Microsoft", LogLevel.Information)
    .AddConsole());

// Add services to the container.
//builder.Services.AddControllersWithViews(); // Add MVC controllers with views
builder.Services.AddRazorPages(); // Add Razor Pages (used for Blazor)
//builder.Services.AddServerSideBlazor(); // Add Blazor Server-side services

// Register any necessary services
builder.Services.AddSingleton<DbConnection>();
builder.Services.AddApplicationServices(); // Custom extension method for adding services

// Add services to the container
builder.Services.AddControllersWithViews();  // MVC
builder.Services.AddServerSideBlazor();      // Blazor

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// Map Blazor and fallback routes
app.MapBlazorHub();
app.MapFallbackToController("Blazor", "Home"); // Set up a fallback to your MVC controller
//app.MapFallbackToPage("/_Host");
app.Run();
