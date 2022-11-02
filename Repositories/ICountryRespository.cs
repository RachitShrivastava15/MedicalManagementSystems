using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface ICountryRespository
    {
        //IEnumerable<Country> GetCountry();
        List<Country> GetCountry();
    }
}
