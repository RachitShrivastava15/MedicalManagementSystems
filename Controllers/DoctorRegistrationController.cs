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
    public class DoctorRegistrationController : Controller
    {
        private readonly IDoctorRespository _doctorRespository;
        private ICountryRespository _countryRespository;
        private readonly IHospitalRespository _hospitalRespository;
        private readonly IUserRespository _userRespository;

        public DoctorRegistrationController(IDoctorRespository doctorRespository,
                                            ICountryRespository countryRespository,
                                            IHospitalRespository hospitalRespository,
                                            IUserRespository userRespository)
        {
            _doctorRespository = doctorRespository;
            _countryRespository = countryRespository;
            _hospitalRespository = hospitalRespository;
            _userRespository = userRespository;
        }
              

        [HttpGet("doctorregistrationcontroller/doctorregistration")]
        public IActionResult DoctorRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            HospitalRegistrationViewModel model2 = new HospitalRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList()
            };
            DoctorRegistrationViewModel model = new DoctorRegistrationViewModel()
            {
                SpecialityList = _doctorRespository.GetSpecialityList(),
                CountryList = model1.CountryList,
                HospitalList = model2.HospitalList
            };

            return View(model);
        }

        [HttpPost("doctorregistrationcontroller/doctorregistration")]
        public IActionResult DoctorRegistration(DoctorRegistrationViewModel model)
        {
            var doctor = new Speciality
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
                RoleName = "Doctor",
                SpecialityName = model.SpecialityName,
                HospitalName = model.HospitalName
            };

            bool success = _doctorRespository.RegisterDoctor(doctor);
            if (success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "Doctor is registered and associated with your hospital",
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

        [HttpGet("doctorregistrationcontroller/doctoravailability")]
        public IActionResult DoctorAvailability(GetHospitalDocTestPharmacyViewModel model)
        {
            var hospital = new Hospital()
            {
                HospitalName = model.HospitalName,
                DoctorId = model.DoctorId
            };
            DoctorAvailabilityViewModel model2 = new DoctorAvailabilityViewModel()
            {
                PageTitle = "Slots",
                DoctorList = _doctorRespository.GetDoctorAvailabilityList(hospital),
                UserEmail = model.UserEmail,
                RolesName = model.RoleName

            };

            return View(model2);
        }


        [HttpGet("doctorregistrationcontroller/doctorcontactdetails")]
        //[HttpPost]
        public IActionResult DoctorContactDetails(GetHospitalDocTestPharmacyViewModel model)
        {
            var user = new User()
            {
                DoctorId = model.DoctorId
            };


            User userdetails = _userRespository.DoctorContactDetails(user);


            return View("UserContactDetails",
                      new UserRegistrationViewModel
                      {
                          PageTitle = "Doctor Details",
                          Email = user.Email,
                          RoleName = user.RoleName,
                          UserDetails = userdetails
                      });

        }

        [HttpGet("doctorregistrationcontroller/appointment")]
        //[HttpPost]
        public IActionResult Appointment(GetHospitalDocTestPharmacyViewModel model)
        {
            //var user = new User()
            //{
            //    DoctorId = model.DoctorId
            //};


            //User userdetails = _userRespository.DoctorContactDetails(user);


            return View("Appointment",
                      new DoctorAvailabilityViewModel
                      {
                          PageTitle = "Appointment"
                          
                      });

        }
    }
}
