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
    public class SignInController : Controller
    {
        private IUserRespository _userRespository;
        private IHospitalRespository _hospitalRespository;

        public SignInController(IUserRespository userRespository,
                                IHospitalRespository hospitalRespository)
        {
            _userRespository = userRespository;
            _hospitalRespository = hospitalRespository;
        }

        [Route("")]
        [HttpGet]
        public IActionResult SignIn()
        {
            if(!ModelState.IsValid)
            {
                RedirectToAction("home");
            }
            return View();
        }

        [HttpPost("signincontroller/signin")]
        public IActionResult SignIn(SignInViewModel model)
        {
            var user = new User
            {
                Email = model.Email,
                Password = model.Password
            };

            var hospital = new Hospital
            {
                Country = "US"
            };

            bool success = _userRespository.UserExistCheck(user);
            User userRoles = _userRespository.UserRoles(user);
            if (success)
            {

                //if (userRoles.RoleName == "HospitalAdmin" || userRoles.RoleName == "Patient" 
                //    || userRoles.RoleName == "Receptionist"
                //    || userRoles.RoleName == "Doctor"
                //    || userRoles.RoleName == "Doctor"
                //    || userRoles.RoleName == "Doctor")
                //{
                    return View("HomeViewModel",
                         new HomeViewModel
                         {
                             //PageTitle = "Home"
                             CountryList = _hospitalRespository.GetCountry(),
                             UserEmail = user.Email,
                             UserRoles = userRoles,
                             HospitalName = _hospitalRespository.GetHospitalNameByUserEmail(user),
                             HospitalListByCountry = _hospitalRespository.GetHospitalListByCountry(hospital)
                             
                         }) ;
                //}
              
                //return View("~/Views/Shared/Error.cshtml");
            }
            else 
            return View("~/Views/Shared/Error.cshtml");
        }


        [HttpPost("signincontroller/home")]
        public IActionResult Home(SignInViewModel model)
        {
            var hospital = new Hospital
            {
                Country = "US"
            };
           
            return View("HomeViewModel",
                     new HomeViewModel
                     {
                            
                           CountryList = _hospitalRespository.GetCountry(),
                         UserEmail = model.Email,
                         UserRoles = model.UserRoles,
                         HospitalName = _hospitalRespository.GetHospitalNameByUserEmail(model),
                         HospitalListByCountry = _hospitalRespository.GetHospitalListByCountry(hospital)

                     });
               

        }
    }
}
