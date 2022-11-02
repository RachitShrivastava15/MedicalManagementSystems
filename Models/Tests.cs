using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class Tests : Pharmacy
    {
        public string TestsId { get; set; }
        public string TestsName { get; set; }
        public string SlotTime { get; set; }
        public string IsAvailable { get; set; }
        public string TestAvailabilityId { get; set; }
    }
}
