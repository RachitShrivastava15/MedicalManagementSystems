using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class GetHospitalDocTestPharmacyViewModel : HomePageViewModel
    {
        public string DoctorId { get; set; }
        public string TestsId { get; set; }
        public string PharmacyId { get; set; }
        public string UserEmail { get; set; }
        public string UserRoleForLoading { get; set; }
    }
}
