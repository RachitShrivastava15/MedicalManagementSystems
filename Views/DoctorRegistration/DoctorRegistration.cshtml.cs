using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MedicalManagementSystem.Models;
using MedicalManagementSystem.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace MedicalManagementSystem.Views.DoctorRegistration
{
    public class DoctorRegistrationModel : PageModel
    {
        public ICountryRespository _countryRespository;

        public DoctorRegistrationModel(ICountryRespository countryRespository)
        {
            _countryRespository = countryRespository;
        }

        [BindProperty]
        public List<Country> country { get; set; }

        public void OnGet()
        {
            country = _countryRespository.GetCountry();
        }
    }
}
