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
    public class PharmacyRegistrationController : Controller
    {
        private readonly IPharmacyRespository _pharmacyRespository;
        private readonly IHospitalRespository _hospitalRespository;
        private readonly ICountryRespository _countryRespository;

        public PharmacyRegistrationController(IPharmacyRespository pharmacyRespository,
                                              IHospitalRespository hospitalRespository,
                                              ICountryRespository countryRespository)
        {
            _pharmacyRespository = pharmacyRespository;
            _hospitalRespository = hospitalRespository;
            _countryRespository = countryRespository;
        }

        [HttpGet("pharmacyregistrationcontroller/pharmacyregistration")]
        public IActionResult PharmacyRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            HospitalRegistrationViewModel model2 = new HospitalRegistrationViewModel()
            {
                HospitalList = _hospitalRespository.GetHospitalList()
            };

            PharmacyRegistrationViewModel model = new PharmacyRegistrationViewModel()
            {
                CountryList = model1.CountryList,
                HospitalList = model2.HospitalList
            };

            return View(model);
        }

        [HttpPost("pharmacyregistrationcontroller/pharmacyregistration")]
        public IActionResult PharmacyRegistration(PharmacyRegistrationViewModel model)
        {
            var pharmacy = new Pharmacy
            {
                PharmacyName = model.PharmacyName,
                Address = model.Address,
                City = model.City,
                Country = model.Country,
                State = model.State,
                Zip = model.Zip,
                Phone = model.Phone,
                Extension = model.Extension,
                Fax = model.Fax,
                HospitalId = model.HospitalName
            };

            bool success = _pharmacyRespository.RegisterPharmacy(pharmacy);
            if (success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "Pharmacy is registered and associated with the hospital",
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

        [HttpGet("pharmacyregistrationcontroller/pharmacyownerregistration")]
        public IActionResult PharmacyOwnerRegistration()
        {
            HomeViewModel model1 = new HomeViewModel()
            {
                CountryList = _countryRespository.GetCountry()
            };

            PharmacyRegistrationViewModel model2 = new PharmacyRegistrationViewModel()
            {
                PharmacyList= _pharmacyRespository.GetPharmacyList(),
                CountryList = model1.CountryList
            };

            return View(model2);
        }

        [HttpPost("pharmacyregistrationcontroller/pharmacyownerregistration")]
        public IActionResult PharmacyOwnerRegistration(PharmacyRegistrationViewModel model)
        {
            var user = new Pharmacy
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
                RoleName = "PharmacyOwner",
                PharmacyId = model.PharmacyName
            };

            bool success = _pharmacyRespository.RegisterPharmacyownerUser(user);
            if (success)
            {
                return View("ThankYou",
                     new ThankYouViewModel
                     {
                         PageTitle = "Registeration",
                         Message = "Pharmacy is registered and associated with the hospital",
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

        [HttpGet("pharmacyregistrationcontroller/pharmacyavailability")]
        public IActionResult PharmacyAvailability(GetHospitalDocTestPharmacyViewModel model)
        {
            var hospital = new Hospital()
            {
                HospitalName = model.HospitalName,
                PharamcyId = model.PharmacyId
            };
            PharmacyAvailabilityViewModel model2 = new PharmacyAvailabilityViewModel()
            {
                PageTitle = "Slots",
                PharmacyList = _pharmacyRespository.GetPharmacyAvailabilityList(hospital),
                UserEmail = model.UserEmail,
                RolesName = model.RoleName
            };

            return View(model2);
        }
    }
}
