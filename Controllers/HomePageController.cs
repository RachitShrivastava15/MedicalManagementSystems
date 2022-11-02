using MedicalManagementSystem.Models;
using MedicalManagementSystem.Repositories;
using MedicalManagementSystem.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Controllers
{
    public class HomePageController : Controller
    {
        private readonly IHospitalRespository _hospitalRespository;
        private ICountryRespository _countryRespository;

        public HomePageController(IHospitalRespository hospitalRespository,
                                  ICountryRespository countryRespository)        
        {            
            _hospitalRespository = hospitalRespository;
            _countryRespository = countryRespository;
        }

        [HttpGet("homepagecontroller/gethospitallistbyname")]

        public IActionResult GETHospitalListByName()
        {
            HomePageViewModel model = new HomePageViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };
            return View(model);

        }

        [HttpPost("homepagecontroller/gethospitallistbyname")]

        public IActionResult GETHospitalListByName(HomePageViewModel model)
        {
            if (model.Country == null)
                model.Country = "US";

            var hospital = new Hospital
            {
                HospitalName = model.HospitalName,
                Country = model.Country
            };


            return View("HomePageViewModel",
                        new HomePageViewModel
                        {
                            PageTitle = "Hospitals",
                            HospitalList = _hospitalRespository.GetHospitalListByName(hospital),
                            UserEmail = model.UserEmail
                        });

        }
    }
}
