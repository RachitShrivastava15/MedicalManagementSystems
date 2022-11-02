using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class PharmacyAvailabilityViewModel : PharmacyRegistrationViewModel
    {
        public string UserEmail { get; set; }
        public string DoctorAvailabilityId { get; set; }
        public string TestAvailabilityId { get; set; }
        public string PharmacyAvailabilityId { get; set; }
    }
}
