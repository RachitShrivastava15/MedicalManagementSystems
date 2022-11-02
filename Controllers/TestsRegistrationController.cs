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
    public class TestsRegistrationController : Controller
    {
        private readonly ITestsRespository _testsRespository;
        private readonly IHospitalRespository _hospitalRespository;
        private readonly ICountryRespository _countryRespository;

        public TestsRegistrationController(ITestsRespository testsRespository,
                                           IHospitalRespository hospitalRespository,
                                           ICountryRespository countryRespository)
        {
            _testsRespository = testsRespository;            
            _hospitalRespository = hospitalRespository;
            _countryRespository = countryRespository;
        }

        [HttpGet("testsregistrationcontroller/testsregistration")]
        public IActionResult TestsRegistration()
        {
            HospitalRegistrationViewModel model2 = new HospitalRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList()
            };

            TestsRegistrationViewModel model = new TestsRegistrationViewModel()
            {
                HospitalList = model2.HospitalList,
                TestsList = _testsRespository.GetTestsList()
            };

            return View(model);
        }

        [HttpPost("testsregistrationcontroller/testsregistration")]
        public IActionResult TestsRegistration(TestsRegistrationViewModel model)
        {
            var tests = new Tests
            {
                TestsName = model.TestsName,               
                HospitalName = model.HospitalName
            };

            bool success = _testsRespository.RegisterTests(tests);
            if (success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "Thanks for registering with us",
                         IsSuccess = true
                     });
            }
            else
            {
                return View("ThankYou",
                       new ThankYouViewModel
                       {
                           PageTitle = "Registeration",
                           Message = "There is some error. please try again",
                           IsSuccess = false
                       });
            }

        }

        [HttpGet("testsregistrationcontroller/testsownerregistration")]
        public IActionResult TestsOwnerRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            TestsRegistrationViewModel model2 = new TestsRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList(),
                CountryList = model1.CountryList
            };

            return View(model2);
        }

        [HttpPost("testsregistrationcontroller/testsownerregistration")]
        public IActionResult TestsOwnerRegistration(TestsRegistrationViewModel model)
        {
            var user = new Tests
            {
                Email = model.Email,
                FirstName = model.FirstName,
                LastName = model.LastName,
                Password = model.Password,
                Address = model.Address,
                City = model.City,
                Country = model.Country,
                State = model.State,
                Zip = model.Zip,
                Phone = model.Phone,
                Extension = model.Extension,
                Fax = model.Fax,
                RoleName = "TestOwner",
                HospitalId = model.HospitalName
            };

            bool success = _testsRespository.RegisterTestownerUser(user);
            if (success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "Thanks for registering with us",
                         IsSuccess = true
                     });
            }
            else
            {
                return View("ThankYou",
                       new ThankYouViewModel
                       {
                           PageTitle = "Registeration",
                           Message = "There is some error. please try again",
                           IsSuccess = false
                       });
            }

        }

        [HttpGet("testsregistrationcontroller/testsavailability")]
        public IActionResult TestsAvailability(GetHospitalDocTestPharmacyViewModel model)
        {
            var test = new Tests()
            {
                HospitalName = model.HospitalName,
                TestsId = model.TestsId
            };
            TestsAvailabilityViewModel model2 = new TestsAvailabilityViewModel()
            {
                PageTitle = "Slots",
                TestsList = _testsRespository.GetTestAvailabilityList(test),
                UserEmail = model.UserEmail,
                RolesName = model.RoleName

            };

            return View(model2);
        }
    }
}
