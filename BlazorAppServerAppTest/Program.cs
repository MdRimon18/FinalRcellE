using Pms.Data;
 
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.EntityFrameworkCore;
using Pms.Data.DbContex;
using Pms.Data.Repository;
using BlazorAppServerAppTest.Models;
using Pms.Data.Repository.Inventory;
using Pms.Data.Repository.Shared;

var builder = WebApplication.CreateBuilder(args);
  builder.Services.AddControllersWithViews();
  IConfiguration configuration;

  configuration = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();

builder.Services.AddDbContext<practiceDbContext>

   (option => option
   .UseSqlServer(configuration.GetConnectionString("DefaultConnection"))
   .EnableSensitiveDataLogging());



// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddSingleton<WeatherForecastService>();
builder.Services.AddScoped<CountryService>();
//builder.Services.AddSingleton<TaskService>();
builder.Services.AddSingleton<DbConnection>();
builder.Services.AddScoped<ProductRepository>();

builder.Services.AddScoped<TaskService>();

builder.Services.AddScoped<OrderService>();
builder.Services.AddScoped<OrderServiceWithSp>();
builder.Services.AddScoped<ColorService>();
builder.Services.AddScoped<CustomerService>();
builder.Services.AddScoped<UserService>();
builder.Services.AddScoped<CompanyService>();
builder.Services.AddScoped<InvoiceService>();
builder.Services.AddScoped<InvoiceItemService>();

builder.Services.AddScoped<WarehouseService>();


builder.Services.AddScoped<CountryServiceV2>();
builder.Services.AddScoped<ShippingByService>();
builder.Services.AddScoped<UnitService>();
builder.Services.AddScoped<BusinessTypesService>();
builder.Services.AddScoped<RoleService>();
builder.Services.AddScoped<InvoiceTypeService>();
builder.Services.AddScoped<LocationService>();
builder.Services.AddScoped<ProductOrCupponCodeService>();
builder.Services.AddScoped<WarehouseService>();
builder.Services.AddScoped<EmailSetupService>();
builder.Services.AddScoped<SmsSettinsService>();
builder.Services.AddScoped<ProductService>();
builder.Services.AddScoped<InvoiceService>();
builder.Services.AddScoped<CompanyService>();
builder.Services.AddScoped<BasicColumnPermissionService>();
builder.Services.AddScoped<PageDetailsService>();
builder.Services.AddScoped<ReviewService>();

builder.Services.AddScoped<SupplierService>();
builder.Services.AddScoped<LanguageService>();
builder.Services.AddScoped<ProductCategoryService>();
builder.Services.AddScoped<AccHeadService>();
builder.Services.AddScoped<StatusSettingService>();
builder.Services.AddScoped<CurrencyService>();
builder.Services.AddScoped<ProductSubCategoryService>();
builder.Services.AddScoped<ProductSizeService>();
builder.Services.AddScoped<CompanyBranceService>();

builder.Services.AddScoped<PaymentTypesService>();
builder.Services.AddScoped<BillingPlanService>();
builder.Services.AddScoped<AccTypeServivce>(); 
//builder.Services.AddSingleton<ProductRepositoyWithSp>();
builder.Services.AddSingleton<TaskRepository>();

builder.Services.AddSingleton<FileUploadService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers(); // Add this line to map controllers
                                // Other endpoint mappings
});
app.Run();
