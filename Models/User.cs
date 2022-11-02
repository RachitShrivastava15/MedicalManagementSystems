using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Models
{
    
    public class User : IdentityUser
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string Phone { get; set; }
        public string Zip { get; set; }
        public string Extension { get; set; }
        public string Fax { get; set; }
        public string RoleName { get; set; }
        public string RoleId { get; set; }

        public int UserId { get; set; }
        public Guid UserGuid { get; set; }
        public int UserRoleId { get; set; }
        public int IsExists { get; set; }

        public string SpecialityName { get; set; }
        public string DoctorId { get; set; }
        public string HospitalName { get; set; }
        public string TestsId { get; set; }
        public string AppointmentId { get; set; }
        public string UserState { get; set; }
        public string LoginId { get; set; }
    }
}
