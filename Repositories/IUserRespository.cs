using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface IUserRespository : ICountryRespository
    {
        bool RegisterUser(User user);

        bool UserExistCheck(User user);

        bool UserPassword(User user);

        bool BookAppointment(Tests user);

        User UserRoles(User user);
        User UserContactDetails(User user);
        List<User> ActiveAppoinmentUserList(User user);

        bool UpdateUserStatus(User user);

        List<User> AllListOfPatientUser();

        User DoctorContactDetails(User user);

        User HospitalContactDetails(User user);

        bool UpdateUserProfile(User user);
    }
}
