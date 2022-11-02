using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface IDoctorRespository : IHospitalRespository
    {
        bool RegisterDoctor(Speciality user);
        List<Speciality> GetSpecialityList();
        List<Doctor> GetDoctorAvailabilityList(Hospital hospital);

    }
}
