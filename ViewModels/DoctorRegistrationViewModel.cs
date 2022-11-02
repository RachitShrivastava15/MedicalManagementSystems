using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class DoctorRegistrationViewModel : HospitalRegistrationViewModel
    {
        public string SpecialityName { get; set; }

        public List<Speciality> SpecialityList { get; set; }
        public List<Doctor> DoctorList { get; set; }
        public string SlotTime { get; set; }
        public string IsAvailable { get; set; }
        public string DoctorId { get; set; }
    }
}
