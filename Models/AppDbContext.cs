using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Protocols;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class AppDbContext : DbContext
    {
        private IConfiguration configuration;
        public string connectionString;
        //public Startup startup = new Startup(Configuration);
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
            //options.UseSqlServer("Database:App:appDB");
            //options.UseSqlServer(startup.Configuration.GetValue<string>("Database:App:appDB"));
            DbContextOptionsBuilder builder = new DbContextOptionsBuilder();
            builder.UseSqlServer(Connection.Configuration.GetValue<string>("Database:App:appDB"));
        }


        //public AppDbContext() 
        //{ }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{         

        //    optionsBuilder.UseSqlServer(startup.Configuration
        //       ["Data:DefaultConnection:ConnectionString"]);

        //}



        public DbSet<Country> Country { get; set; }
        public DbSet<User> User { get; set; }
        public DbSet<Doctor> Doctor { get; set; }
        public DbSet<Hospital> Hospital { get; set; }
        public DbSet<Speciality> Speciality { get; set; }
        //public static IConfiguration Configuration { get; private set; }


        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.UseSqlServer(configuration.GetConnectionString("Database:App:appDB"));// GetValue<string>("Database:App:appDB"));
        //}

        //public string DatabaseConnection()
        //{
        //    return connectionString = configuration.GetValue<string>("Database:App:appDB");
        //}
    }

}

    public static class Connection
    {
             public static IConfiguration Configuration;
    }
