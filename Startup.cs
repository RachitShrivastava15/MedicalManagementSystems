using MedicalManagementSystem.Models;
using MedicalManagementSystem.Repositories;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace MedicalManagementSystem
{
    public class Startup
    {
        public string connectionString;

        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
            Connection.Configuration = configuration;
        }
               

        public IConfiguration Configuration { get; set; }

        

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddRazorPages();
            connectionString = Configuration.GetValue<string>("Database:App:appDB");
            services.AddDbContextPool<AppDbContext>(options =>
            {
                options.UseSqlServer(connectionString);
                
            });
            services.AddControllersWithViews();
            services.AddTransient<ICountryRespository, SQLCountryRepository>();
            services.AddTransient<IUserRespository, SQLUserRepository>();
            services.AddTransient<IHospitalRespository, SQLHospitalRepository>();
            services.AddTransient<IDoctorRespository, SQLDoctorRespository>();
            services.AddTransient<IPharmacyRespository, SQLPharmacyRepository>();
            services.AddTransient<ITestsRespository, SQLTestsRepository>();
            services.AddDbContext<AppDbContext>(ServiceLifetime.Transient);
            services.AddControllers();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {

                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}"
                    );
                //endpoints.MapControllers();
                endpoints.MapRazorPages();
            });
        }
    }
}
