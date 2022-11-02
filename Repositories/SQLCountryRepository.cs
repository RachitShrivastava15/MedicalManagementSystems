using MedicalManagementSystem.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class SQLCountryRepository : ICountryRespository
    {
        private readonly AppDbContext context;
        
        public SQLCountryRepository(AppDbContext context)
        {
            this.context = context;

        }

        public List<Country> GetCountry()
        {
            
            List<Country> countryList = new List<Country>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetCountries";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while(results.Read())
                {
                    Country finalCountry = new Country();
                    finalCountry.CountryISO2 = Convert.ToString(results["CountryISO2"]);
                    finalCountry.CountryName = Convert.ToString(results["CountryName"]);
                    
                    countryList.Add(finalCountry);
                    i++;
                    
                }
                
            }
           
            return countryList;
        }
    }
}
