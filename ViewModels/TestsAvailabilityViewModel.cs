using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class TestsAvailabilityViewModel : TestsRegistrationViewModel
    {
        public string UserEmail { get; set; }
        public string TestAvailabilityId { get; set; }
    }
}
