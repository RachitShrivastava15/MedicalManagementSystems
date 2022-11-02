using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface IPharmacyRespository : IHospitalRespository
    {
        bool RegisterPharmacy(Pharmacy pharmacy);

        List<Pharmacy> GetPharmacyList();

        bool RegisterPharmacyownerUser(Pharmacy user);

        List<Pharmacy> GetPharmacyAvailabilityList(Hospital hospital);
    }
}
