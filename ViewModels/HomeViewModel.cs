using MedicalManagementSystem.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class HomeViewModel : User
    {
        
        public List<Country> CountryList { get; set; }
        public string PageTitle { get; set; }
        public string HospitalName { get; set; }
        public List<Hospital> HospitalList { get; set; }
        public string Country { get; set; }
        public string UserEmail { get; set; }
        public User UserRoles { get; set; }
        public string RolesName { get; set; }
        public User UserDetails { get; set; }
        public List<User> PatientList { get; set; }
        public string UserRoleForLoading { get; set; }
        public List<Hospital> HospitalListByCountry { get; set; }
    }
}
