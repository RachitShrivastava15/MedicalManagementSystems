using MedicalManagementSystem.Helpers;
using MedicalManagementSystem.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public class SQLTestsRepository : ITestsRespository
    {
        private readonly AppDbContext context;

        public SQLTestsRepository(AppDbContext context)
        {
            this.context = context;

        }

        public List<Country> GetCountry()
        {
            throw new NotImplementedException();
        }

        public List<Hospital> GetHospitalList()
        {
            throw new NotImplementedException();
        }

        public List<Tests> GetTestsList()
        {
            List<Tests> testsList = new List<Tests>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetTestsList";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Tests finaltest = new Tests();
                    finaltest.TestsId = Convert.ToString(results["TestsId"]);
                    finaltest.TestsName = Convert.ToString(results["TestsName"]);

                    testsList.Add(finaltest);
                    i++;

                }

            }

            return testsList;
        }

        public bool RegisterAdminUser(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public bool RegisterHospital(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public bool RegisterTests(Tests test)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateTests";
                cmm.Parameters.Add(new SqlParameter("@testsname", test.TestsName));
                cmm.Parameters.Add(new SqlParameter("@hospitalid", test.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@testsId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "@testsId", DataRowVersion.Default, null));
              
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                if (results != null)
                {
                    return true;
                }
                else
                    return false;
            }
        }

        public List<Tests> GetTestAvailabilityList(Tests hospital)
        {

            List<Tests> testsList = new List<Tests>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetTestAvailabilityByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@testid", hospital.TestsId));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Tests test = new Tests();
                    test.SlotTime = Convert.ToString(results["SlotTime"]);
                    test.IsAvailable = Convert.ToString(results["IsAvailable"]);
                    test.TestAvailabilityId = Convert.ToString(results["TestAvailabilityId"]);
                    testsList.Add(test);
                    i++;

                }

            }

            return testsList;
        }

        public bool RegisterUser(User user)
        {
            throw new NotImplementedException();
        }

        public bool UserExistCheck(User user)
        {
            throw new NotImplementedException();
        }

        public bool UserPassword(User user)
        {
            throw new NotImplementedException();
        }

        public bool RegisterTestownerUser(Tests user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateTestsOwnerUser";
                cmm.Parameters.Add(new SqlParameter("@emailAddress", user.Email));
                cmm.Parameters.Add(new SqlParameter("@firstName", user.FirstName));
                cmm.Parameters.Add(new SqlParameter("@lastName", user.LastName));
                cmm.Parameters.Add(new SqlParameter("@salt", finalPassword.Salt));
                cmm.Parameters.Add(new SqlParameter("@hash", finalPassword.Hash));
                cmm.Parameters.Add(new SqlParameter("@address", user.Address));
                cmm.Parameters.Add(new SqlParameter("@city", user.City));
                cmm.Parameters.Add(new SqlParameter("@country", user.Country));
                cmm.Parameters.Add(new SqlParameter("@state", user.State));
                cmm.Parameters.Add(new SqlParameter("@zip", user.Zip));
                cmm.Parameters.Add(new SqlParameter("@phone", user.Phone));
                cmm.Parameters.Add(new SqlParameter("@extension", user.Extension));
                cmm.Parameters.Add(new SqlParameter("@fax", user.Fax));
                cmm.Parameters.Add(new SqlParameter("@rolename", user.RoleName));
                cmm.Parameters.Add(new SqlParameter("@hospitalId", user.HospitalId));
                cmm.Parameters.Add(new SqlParameter("@userid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userguid", SqlDbType.UniqueIdentifier, 32, ParameterDirection.Output, false, 0, 20, "userguid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userRoleId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userRoleId", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@testsownerid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "testsownerid", DataRowVersion.Default, null));
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                if (results != null)
                {
                    return true;
                }
                else
                    return false;

            }
            
        }

        public bool RegisterReceptionistUser(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public List<Hospital> GetHospitalListByName(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public List<User> GetHospitalDoctorList(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public List<Tests> GetHospitalTestList(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public List<Pharmacy> GetHospitalPharmacyList(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public bool BookAppointment(Tests user)
        {
            throw new NotImplementedException();
        }

        public User UserRoles(User user)
        {
            throw new NotImplementedException();
        }

        public User UserContactDetails(User user)
        {
            throw new NotImplementedException();
        }

        public List<User> ActiveAppoinmentUserList(User user)
        {
            throw new NotImplementedException();
        }

        public bool UpdateUserStatus(User user)
        {
            throw new NotImplementedException();
        }

        public string GetHospitalNameByUserEmail(User user)
        {
            throw new NotImplementedException();
        }

        public List<User> AllListOfPatientUser()
        {
            throw new NotImplementedException();
        }

        public User DoctorContactDetails(User user)
        {
            throw new NotImplementedException();
        }

        public User HospitalContactDetails(User user)
        {
            throw new NotImplementedException();
        }

        public bool UpdateUserProfile(User user)
        {
            throw new NotImplementedException();
        }

        public List<Hospital> GetHospitalListByCountry(Hospital hospital)
        {
            throw new NotImplementedException();
        }
    }
}
