using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface IHospitalRespository : IUserRespository
    {
        bool RegisterHospital(Hospital hospital);

        List<Hospital> GetHospitalList();

        bool RegisterAdminUser(Hospital hospital);
        bool RegisterReceptionistUser(Hospital hospital);

        List<Hospital> GetHospitalListByName(Hospital hospital);

        List<User> GetHospitalDoctorList(Hospital hospital);

        List<Tests> GetHospitalTestList(Hospital hospital);

        List<Pharmacy> GetHospitalPharmacyList(Hospital hospital);
        string GetHospitalNameByUserEmail(User user);

        List<Hospital> GetHospitalListByCountry(Hospital hospital);
    }
}
