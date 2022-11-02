using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class TestsRegistrationViewModel : HospitalRegistrationViewModel
    {
        public string TestSId { get; set; }
        public string TestsName { get; set; }
        public List<Tests> TestsList { get; set; }
    }
}
