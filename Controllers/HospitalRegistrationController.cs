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
    public class HospitalRegistrationController : Controller
    {
        private readonly IHospitalRespository _hospitalRespository;
        private readonly ICountryRespository _countryRespository;
        private readonly IUserRespository _userRespository;

        public HospitalRegistrationController(IHospitalRespository hospitalRespository, 
                                              ICountryRespository countryRespository,
                                              IUserRespository userRespository)
        {
            _hospitalRespository = hospitalRespository;
            _countryRespository = countryRespository;
            _userRespository = userRespository;
        }

        [HttpGet("hospitalregistrationcontroller/hospitalregistration")]
        public IActionResult HospitalRegistration()
        {
            HospitalRegistrationViewModel model1 = new HospitalRegistrationViewModel()
            {
                CountryList = _hospitalRespository.GetCountry()
            };
            return View(model1);
        }

        [HttpPost("hospitalregistrationcontroller/hospitalregistration")]
        public IActionResult HospitalRegistration(HospitalRegistrationViewModel model)
        {
            var hospital = new Hospital
            {
                HospitalName = model.HospitalName,
                Address = model.Address,
                City = model.City,
                Country = model.Country,    
                State = model.State,
                Zip = model.Zip,
                Phone = model.Phone,
                Extension = model.Extension,
                Fax = model.Fax
            };

            bool success = _hospitalRespository.RegisterHospital(hospital);
            if(success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "New Hospital is registered.",
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
                
        [HttpGet("hospitalregistrationcontroller/hospitaladminregistration")]
        public IActionResult HospitalAdminRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            HospitalRegistrationViewModel model2 = new HospitalRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList(),
                CountryList = model1.CountryList
            };

            return View(model2);
        }


        [HttpPost("hospitalregistrationcontroller/hospitaladminregistration")]
        public IActionResult HospitalAdminRegistration(HospitalRegistrationViewModel model)
        {
            var user = new Hospital
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
                RoleName = "HospitalAdmin",
                HospitalId = model.HospitalName
            };

            bool success = _hospitalRespository.RegisterAdminUser(user);
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

        [HttpGet("hospitalregistrationcontroller/receptionistregistration")]
        public IActionResult ReceptionistRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            HospitalRegistrationViewModel model2 = new HospitalRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList(),
                CountryList = model1.CountryList
            };

            return View(model2);
        }


        [HttpPost("hospitalregistrationcontroller/receptionistregistration")]
        public IActionResult ReceptionistRegistration(HospitalRegistrationViewModel model)
        {
            var user = new Hospital
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
                RoleName = "Receptionist",
                HospitalId = model.HospitalName
            };

            bool success = _hospitalRespository.RegisterReceptionistUser(user);
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

        [HttpGet("hospitalregistrationcontroller/gethospitaldoctestpharmacy")]
        public IActionResult GetHospitalDocTestPharmacy(Hospital hospital)
        {            

            GetHospitalDocTestPharmacyViewModel model2 = new GetHospitalDocTestPharmacyViewModel()
            {
                PageTitle = hospital.HospitalName,
                DoctorList = _hospitalRespository.GetHospitalDoctorList(hospital),
                TestsList = _hospitalRespository.GetHospitalTestList(hospital),
                PharmacyList = _hospitalRespository.GetHospitalPharmacyList(hospital),
                HospitalName = hospital.HospitalName,
                UserEmail = hospital.UserEmail,
                UserRoleForLoading = hospital.UserRoleForLoading,
                PatientList = _userRespository.AllListOfPatientUser()
            };

            return View(model2);
        }


        [HttpGet("hospitalregistrationcontroller/hospitalcontactdetails")]
        //[HttpPost]
        public IActionResult HospitalContactDetails(GetHospitalDocTestPharmacyViewModel model)
        {
            var user = new User()
            {
                HospitalName = model.HospitalName
            };


            User userdetails = _userRespository.HospitalContactDetails(user);


            return View("UserContactDetails",
                      new UserRegistrationViewModel
                      {
                          PageTitle = "Hospital Details",
                          Email = user.Email,
                          RoleName = user.RoleName,
                          UserDetails = userdetails
                      });

        }
    }
}
