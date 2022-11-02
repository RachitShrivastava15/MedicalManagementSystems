using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class Speciality : Doctor
    {
        public string SpecialityId { get; set; }
        public string SpecialityName { get; set; }
    }
}
