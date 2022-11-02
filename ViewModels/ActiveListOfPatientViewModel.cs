using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class ActiveListOfPatientViewModel : GetHospitalDocTestPharmacyViewModel
    {
        public List<User> ActiveUser { get; set; }
    }
}
