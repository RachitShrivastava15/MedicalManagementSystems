using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class HomePageViewModel : HospitalRegistrationViewModel
    {
        public string HospitalName { get; set; }
        public string UserEmail { get; set; }
    }
}
