using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    public class Hospital : User
    {
        public string HospitalName { get; set; }
        public string HospitalId { get; set; }
        public string PharamcyId { get; set; }
        public string UserEmail { get; set; }
        public User UserDetails { get; set; }
        public User UserRoles { get; set; }
        public string UserRoleForLoading { get; set; }
    }
}
