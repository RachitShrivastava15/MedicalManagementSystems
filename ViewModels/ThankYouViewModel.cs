using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class ThankYouViewModel : UserRegistrationViewModel
    {
        public string PageTitle { get; set; }
        public string Message { get; set; }
        public bool IsSuccess { get; set; }
        public string UserEmail { get; set; }
        public string RolesName { get; set; }
        public User UserDetails { get; set; }
        public string HospitalName { get; internal set; }
    }
}
