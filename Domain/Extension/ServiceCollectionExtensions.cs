using Microsoft.Extensions.DependencyInjection;
using Pms.Data.Repository.Inventory;
using Pms.Data.Repository.Shared;
using Pms.Data.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Pms.Data.Repository.Accounts;

namespace Domain.Extension
{
    public static class ServiceCollectionExtensions
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
           // services.AddScoped<CountryService>();
            //services.AddSingleton<DbConnection>();
            services.AddScoped<ProductRepository>();
           // services.AddScoped<TaskService>();
         //   services.AddScoped<OrderService>();
            services.AddScoped<OrderServiceWithSp>();
            services.AddScoped<ColorService>();
            services.AddScoped<CustomerService>();
            services.AddScoped<UserService>();
            services.AddScoped<CompanyService>();
            services.AddScoped<InvoiceService>();
            services.AddScoped<InvoiceItemService>();
            services.AddScoped<ProductSpecificationService>();
            services.AddScoped<ProductSkuService>();
            services.AddScoped<WarehouseService>();
            services.AddScoped<NotificationByService>();
            services.AddScoped<CountryServiceV2>();
            services.AddScoped<ShippingByService>();
            services.AddScoped<UnitService>();
            services.AddScoped<BusinessTypesService>();
            services.AddScoped<RoleService>();
            services.AddScoped<InvoiceTypeService>();
            services.AddScoped<LocationService>();
            services.AddScoped<ProductOrCupponCodeService>();
            services.AddScoped<WarehouseService>(); // Duplicate registrations can be removed
            services.AddScoped<EmailSetupService>();
            services.AddScoped<SmsSettinsService>();
            services.AddScoped<ProductService>();
            services.AddScoped<BasicColumnPermissionService>();
            services.AddScoped<PageDetailsService>();
            services.AddScoped<ReviewService>();
            services.AddScoped<SupplierService>();
            services.AddScoped<LanguageService>();
            services.AddScoped<ProductCategoryService>();
            services.AddScoped<AccHeadService>();
            services.AddScoped<StatusSettingService>();
            services.AddScoped<CurrencyService>();
            services.AddScoped<ProductSubCategoryService>();
            services.AddScoped<BrandService>();
            services.AddScoped<ProductSizeService>();
            services.AddScoped<CompanyBranceService>();
            services.AddScoped<CustomerPaymentDtlsService>();
            services.AddScoped<ProductSerialNumbersService>();
            services.AddScoped<AccountsDailyExpanseService>();
            services.AddScoped<PaymentTypesService>();
            services.AddScoped<BillingPlanService>();
            services.AddScoped<AccTypeServivce>();
            services.AddScoped<BrandService>(); // Another duplicate

            // Register your services here
            services.AddScoped<BodyPartService>();
            services.AddScoped<ProductMediaService>();
            //services.AddSingleton<ProductRepositoyWithSp>();
            services.AddSingleton<TaskRepository>();
            services.AddSingleton<FileUploadService>();
            services.AddSingleton<ToastService>();

            return services;
        }
        
    }
}
