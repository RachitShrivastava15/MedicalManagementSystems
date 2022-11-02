using MedicalManagementSystem.Models;
using MedicalManagementSystem.Repositories;
using MedicalManagementSystem.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Controllers
{
    public class UserRegistrationController : Controller
    {        
        private readonly IUserRespository _userRespository;
       

        public UserRegistrationController(IUserRespository userRespository)
        {
            _userRespository = userRespository;
        }

        [HttpGet("userregistrationcontroller/userregistration")]
        public IActionResult UserRegistration()
        {
            UserRegistrationViewModel model1 = new UserRegistrationViewModel()
            {
                CountryList = _userRespository.GetCountry()
            };
            return View(model1);
        }


        [HttpPost("userregistrationcontroller/userregistration")]
        public IActionResult UserRegistration(UserRegistrationViewModel model)
        {
           
            var user = new User { 
                Email = model.Email,
                Password = model.Password,
                FirstName = model.FirstName,
                LastName = model.LastName,
                Country = model.Country,
                RoleName = "Patient"
                };

            bool success = _userRespository.RegisterUser(user);
            
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

        [HttpPost("userregistrationcontroller/userappointment")]
        //[HttpPost]
        public IActionResult UserAppointment(DoctorAvailabilityViewModel model)
        {
            var test = new Tests()
            {
                UserEmail = model.UserEmail,
                DoctorAvailabilityId = model.DoctorAvailabilityId,
                TestAvailabilityId = model.TestAvailabilityId,
                PharmacyAvailabilityId = model.PharmacyAvailabilityId
            };
            //DoctorAvailabilityViewModel model2 = new DoctorAvailabilityViewModel()
            //{
            //    PageTitle = "Slots",
            //    //DoctorList = _doctorRespository.GetDoctorAvailabilityList(hospital),
            //    UserEmail = model.UserEmail

            //};

            //return View(model2);

            bool result = _userRespository.BookAppointment(test);

            if (result)
            {
                return View("ThankYou",
                          new ThankYouViewModel
                          {
                              PageTitle = "Success",
                              Message = "Appointment is booked",
                              IsSuccess = true,
                              UserEmail = model.UserEmail,
                              RolesName = model.RoleName
                          });
            }
            else
            {
                return View("ThankYou",
                          new ThankYouViewModel
                          {
                              PageTitle = "Error",
                              Message = "Try Again",
                              IsSuccess = true
                          });
            }
        }

        [HttpGet("userregistrationcontroller/usercontactdetails")]
        //[HttpPost]
        public IActionResult UserContactDetails(HomeViewModel model)
        {
            var user = new User()
            {
                Email = model.UserEmail,
                RoleName = model.RolesName
            };
          

            User userdetails = _userRespository.UserContactDetails(user);

           
                return View("UserContactDetails",
                          new UserRegistrationViewModel
                          {
                              PageTitle = "Profile",
                              Email = user.Email,
                              RoleName = user.RoleName,
                              UserDetails = userdetails
                          });
           
        }

        [HttpPost("userregistrationcontroller/updateusercontactdetails")]
        //[HttpPost]
        public IActionResult UpdateUserContactDetails(UserRegistrationViewModel model)
        {
            var user = new User()
            {
                Email = model.UserEmail,
                FirstName = model.FirstName,
                LastName = model.LastName,
                Address = model.Address,
                City = model.City,
                Country = model.Country,
                State = model.State,
                Zip = model.Zip,
                Phone = model.Phone,
                Extension = model.Extension,
                Fax = model.Fax,
                RoleName = model.RolesName
            };

            bool success = _userRespository.UpdateUserProfile(user);

            if (success)
            {

                User userdetails = _userRespository.UserContactDetails(user);


                return View("UserContactDetails",
                          new UserRegistrationViewModel
                          {
                              PageTitle = "Profile",
                              Email = user.Email,
                              RoleName = user.RoleName,
                              UserDetails = userdetails
                          });
            }
            else
            {
                return View("UserContactDetails",
                          new UserRegistrationViewModel
                          {
                              PageTitle = "Profile",
                              Email = user.Email,
                              RoleName = user.RoleName,
                              UserDetails = model.UserDetails
                          });
            }
        }


        [HttpGet("userregistrationcontroller/activelistofpatient")]
        public IActionResult ActiveListOfPatient(Hospital user)
        {
            User user1 = new User();

            if (user.RoleName == "Receptionist")
            {

                user1.Email = user.UserEmail;
                user1.UserState = "1";
                user1.LoginId = "1";
                
            }
            else if(user.RoleName == "Doctor")
            {

                user1.Email = user.UserEmail;
                user1.UserState = "4";
                user1.LoginId = "2";
               
            }
            else if (user.RoleName == "PharmacyOwner")
            {

                user1.Email = user.UserEmail;
                user1.UserState = "6";
                user1.LoginId = "3";

            }
            else if (user.RoleName == "TestOwner")
            {

                user1.Email = user.UserEmail;
                user1.UserState = "8";
                user1.LoginId = "4";

            }
            ActiveListOfPatientViewModel model = new ActiveListOfPatientViewModel()
            {
                PageTitle = "List Of Users",
                UserEmail = user1.Email,
                ActiveUser = _userRespository.ActiveAppoinmentUserList(user1),
                UserDetails = user.UserDetails,
                HospitalName = user.HospitalName, 
                UserRoleForLoading = user.RoleName
                
            };            

            return View(model);
        }

        [HttpPost("userregistrationcontroller/routeusertodoctor")]
        public IActionResult RouteUserToDoctor(Hospital user)
        {
            user.UserState = "4";

            bool result = _userRespository.UpdateUserStatus(user);

            if(result)
            {
                return View("ThankYou",
                    new ThankYouViewModel
                    {
                        PageTitle = "Success",
                        Message = "User is Checked In and Routed to Doctor",
                        UserEmail = user.UserEmail,
                        UserDetails = user,
                        HospitalName = user.HospitalName,
                        
                    });
            }
            else
            {
                return View();
            }

            
        }

        [HttpPost("userregistrationcontroller/routeusertopharmacy")]
        public IActionResult RouteUserToPharmacy(Hospital user)
        {
            user.UserState = "6";

            bool result = _userRespository.UpdateUserStatus(user);

            if (result)
            {
                return View("ThankYou",
                    new ThankYouViewModel
                    {
                        PageTitle = "Success",
                        Message = "User is Checked In and Routed to Pharmacy",
                        UserEmail = user.UserEmail,
                        UserDetails = user,
                        HospitalName = user.HospitalName,

                    });
            }
            else
            {
                return View();
            }


        }

        [HttpPost("userregistrationcontroller/routeusertotestlab")]
        public IActionResult RouteUserToTestLab(Hospital user)
        {
            user.UserState = "8";

            bool result = _userRespository.UpdateUserStatus(user);

            if (result)
            {
                return View("ThankYou",
                    new ThankYouViewModel
                    {
                        PageTitle = "Success",
                        Message = "User is Checked In and Routed to Test Lab",
                        UserEmail = user.Email,
                        UserDetails = user,
                        HospitalName = user.HospitalName,

                    });
            }
            else
            {
                return View();
            }


        }

        

    }
}
