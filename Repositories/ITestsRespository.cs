using MedicalManagementSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public interface ITestsRespository : IHospitalRespository
    {
        bool RegisterTests(Tests test);

        List<Tests> GetTestsList();

        bool RegisterTestownerUser(Tests user);

        List<Tests> GetTestAvailabilityList(Tests hospital);
    }
}
