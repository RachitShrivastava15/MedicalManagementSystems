using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class PharmacyRegistrationViewModel : HospitalRegistrationViewModel
    {
        public string PharmacyId { get; set; }
        public string PharmacyName { get; set; }

        public List<Pharmacy> PharmacyList { get; set; }
    }
}
