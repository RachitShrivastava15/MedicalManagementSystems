using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class Pharmacy : Doctor
    {
        public string PharmacyId { get; set; }
        public string PharmacyName { get; set; }
        public string SlotTime { get; set; }
        public string IsAvailable { get; set; }
        public string PharmacyAvailabilityId { get; set; }
    }
}
