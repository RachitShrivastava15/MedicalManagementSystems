using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class HospitalRegistrationViewModel : UserRegistrationViewModel
    {
        public string HospitalName { get; set; }
        public List<Hospital> HospitalList { get; set; }

        public string PhotoPath { get; set; }
        public List<User> DoctorList { get; set; }
        public List<Tests> TestsList { get; set; }
        public List<Pharmacy> PharmacyList { get; set; }
        public string TestsId { get; set; }
        public string PharmacyId { get; set; }
    }
}
