using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class Doctor : Hospital
    {
        public string DoctorName { get; set; }
        public string DoctorId { get; set; }    
        public string SlotTime { get; set; }
        public string IsAvailable { get; set; }
        public string DoctorAvailabilityId { get; set; }
    }
}
