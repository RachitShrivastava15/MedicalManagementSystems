using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    [Keyless]
    public class Country
    {
        public string CountryName { get; set; }
        public string CountryISO2 { get; set; }
    }
}
