using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.ViewModels
{
    public class UserRegistrationViewModel : HomeViewModel
    {      
        public string PageTitle { get; set; }

        [Required]
        
        public string Email { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm Password")]
        [Compare("Password", ErrorMessage =" Password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        [Required]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        public string City { get; set; }

        [Required]
        public string Country { get; set; }

        [Required]
        public string State { get; set; }

        [Required]
        public string Phone { get; set; }

        public string Zip { get; set; }
        public string Extension { get; set; }
        public string Fax { get; set; }
        public string SelectedCountry { get; set; }
        public User UserDetails { get; set; }

    }
}
