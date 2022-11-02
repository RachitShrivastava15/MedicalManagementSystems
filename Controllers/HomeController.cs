using MedicalManagementSystem.Models;
using MedicalManagementSystem.Repositories;
using MedicalManagementSystem.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Controllers
{
    //[Route("Home")]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ICountryRespository _countryRespository;
       

        //public HomeController(ILogger<HomeController> logger)
        //{
        //    _logger = logger;
        //}

        public HomeController(ICountryRespository countryRespository)
        {
            _countryRespository = countryRespository;            
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        //[HttpGet("[action]")]
        [Route("Home")]
        //[Route("/")]
        public ViewResult GetCountry()
        {

            HomeViewModel homeViewModel = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry(),
                PageTitle = "List of Country"
            };
            return View(homeViewModel);
            //return View();
        }


       

    }
}
