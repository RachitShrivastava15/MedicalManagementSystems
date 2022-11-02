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
    public class SQLHospitalRepository : IHospitalRespository
    {
        private readonly AppDbContext context;
        private HashSalt hashSalt = new HashSalt();


        public SQLHospitalRepository(AppDbContext context)
        {
            this.context = context;

        }

        public bool RegisterHospital(Hospital hospital)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateHospital";
                cmm.Parameters.Add(new SqlParameter("@HospitalName", hospital.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@address", hospital.Address));
                cmm.Parameters.Add(new SqlParameter("@city", hospital.City));
                cmm.Parameters.Add(new SqlParameter("@country", hospital.Country));
                cmm.Parameters.Add(new SqlParameter("@state", hospital.State));
                cmm.Parameters.Add(new SqlParameter("@zip", hospital.Zip));
                cmm.Parameters.Add(new SqlParameter("@phone", hospital.Phone));
                cmm.Parameters.Add(new SqlParameter("@extension", hospital.Extension));
                cmm.Parameters.Add(new SqlParameter("@fax", hospital.Fax));
                cmm.Parameters.Add(new SqlParameter("@hospitalId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "hospitalId", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@hospitalguid", SqlDbType.UniqueIdentifier, 256, ParameterDirection.Output, false, 0, 20, "hospitalguid", DataRowVersion.Default, null));
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

        public List<Hospital> GetHospitalList()
        {
            List<Hospital> hospitalList = new List<Hospital>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetHosiptalList";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Hospital finalHospital = new Hospital();
                    finalHospital.HospitalId = Convert.ToString(results["HospitalId"]);
                    finalHospital.HospitalName = Convert.ToString(results["HospitalName"]);

                    hospitalList.Add(finalHospital);
                    i++;

                }

            }

            return hospitalList;
        }

        public List<Hospital> GetHospitalListByCountry(Hospital hospital)
        {
            List<Hospital> hospitalList = new List<Hospital>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetHosiptalListByCountry";
                cmm.Parameters.Add(new SqlParameter("@countrycode", hospital.Country));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Hospital finalHospital = new Hospital();
                    finalHospital.HospitalId = Convert.ToString(results["HospitalId"]);
                    finalHospital.HospitalName = Convert.ToString(results["HospitalName"]);

                    hospitalList.Add(finalHospital);
                    i++;

                }

            }

            return hospitalList;
        }


        public List<Hospital> GetHospitalListByName(Hospital hospital)
        {
            List<Hospital> hospitalList = new List<Hospital>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetHosiptalListByName";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@countrycode", hospital.Country));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Hospital finalHospital = new Hospital();
                    finalHospital.HospitalId = Convert.ToString(results["HospitalId"]);
                    finalHospital.HospitalName = Convert.ToString(results["HospitalName"]);

                    hospitalList.Add(finalHospital);
                    i++;

                }

            }

            return hospitalList;
        }

        public List<User> GetHospitalDoctorList(Hospital hospital)
        {
            List<User> userList = new List<User>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetDoctorListByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    User finalUser = new User();
                    finalUser.Email = Convert.ToString(results["Email"]);
                    finalUser.FirstName = Convert.ToString(results["FirstName"]);
                    finalUser.LastName = Convert.ToString(results["LastName"]);
                    finalUser.SpecialityName = Convert.ToString(results["SpecialityName"]);
                    finalUser.DoctorId = Convert.ToString(results["DoctorId"]);
                    userList.Add(finalUser);
                    i++;

                }

            }

            return userList;
        }

        public List<Tests> GetHospitalTestList(Hospital hospital)
        {
            List<Tests> testsList = new List<Tests>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetTestListByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Tests finaltest = new Tests();
                    finaltest.TestsName = Convert.ToString(results["TestsName"]);
                    finaltest.TestsId = Convert.ToString(results["TestsId"]);
                    testsList.Add(finaltest);
                    i++;

                }

            }

            return testsList;
        }

        public List<Pharmacy> GetHospitalPharmacyList(Hospital hospital)
        {
            List<Pharmacy> pharmacyList = new List<Pharmacy>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetPharmacyListByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Pharmacy pharmacytest = new Pharmacy();
                    pharmacytest.PharmacyName = Convert.ToString(results["PharmacyName"]);
                    pharmacytest.PharmacyId = Convert.ToString(results["PharmacyId"]);
                    pharmacyList.Add(pharmacytest);
                    i++;

                }

            }

            return pharmacyList;
        }

        public string GetHospitalNameByUserEmail(User user)
        {
           Hospital hospitalName = new Hospital();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetHospitalNameByUserEmail";
                cmm.Parameters.Add(new SqlParameter("@emailAddress", user.Email));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
               
                while (results.Read())
                {

                    hospitalName.HospitalName = Convert.ToString(results["hospitalName"]);
                    
                    

                }

            }

            return hospitalName.HospitalName;
        }

        public bool RegisterAdminUser(Hospital user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateHospitalAdminUser";
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

        public List<Country> GetCountry()
        {
            List<Country> countryList = new List<Country>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetCountries";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Country finalCountry = new Country();
                    finalCountry.CountryISO2 = Convert.ToString(results["CountryISO2"]);
                    finalCountry.CountryName = Convert.ToString(results["CountryName"]);

                    countryList.Add(finalCountry);
                    i++;

                }

            }
            return countryList;

        }

        public bool RegisterUser(User user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateUser";
                cmm.Parameters.Add(new SqlParameter("@emailAddress", user.Email));
                cmm.Parameters.Add(new SqlParameter("@salt", finalPassword.Salt));
                cmm.Parameters.Add(new SqlParameter("@hash", finalPassword.Hash));
                cmm.Parameters.Add(new SqlParameter("@firstName", user.FirstName));
                cmm.Parameters.Add(new SqlParameter("@lastName", user.LastName));
                cmm.Parameters.Add(new SqlParameter("@rolename", user.RoleName));
                cmm.Parameters.Add(new SqlParameter("@userid", user.UserId));
                cmm.Parameters.Add(new SqlParameter("@userguid", user.UserGuid));
                cmm.Parameters.Add(new SqlParameter("@userRoleId", user.UserRoleId));
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

        public bool UserExistCheck(User user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "VerifyUserExists";
                cmm.Parameters.Add(new SqlParameter("@emailAddress", user.Email));
                cmm.Parameters.Add(new SqlParameter("@isExists", user.IsExists));
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();
                cnn.Close();
                if (results != null)
                {
                    bool passwordMatch = UserPassword(user);
                    if (passwordMatch)
                    {
                        return true;
                    }
                    else
                        return false;
                }
                else
                    return false;
            }
        }

        public bool UserPassword(User user)
        {

            using (var cnn = this.context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetUserSaltHash";
                cmm.Parameters.Add(new SqlParameter("@emailAddress", user.Email));
                cmm.Parameters.Add(new SqlParameter("@passworduserhash", SqlDbType.VarChar, 4000, ParameterDirection.Output, false, 0, 20, "passworduserhash", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@passwordsalt", SqlDbType.VarChar, 256, ParameterDirection.Output, false, 0, 20, "passwordsalt", DataRowVersion.Default, null));
                cmm.Connection = cnn;

                cnn.Open();
                var results = cmm.ExecuteReader();
                cnn.Close();

                if (results != null)
                {
                    string hash = (string)cmm.Parameters["@passworduserhash"].Value;
                    string salt = (string)cmm.Parameters["@passwordsalt"].Value;
                    bool passwordMatched = hashSalt.VerifyPassword(user.Password, hash, salt);
                    if (passwordMatched)
                        return true;
                    else
                        return false;
                }
                else
                    return false;
            }
        }

        public bool RegisterReceptionistUser(Hospital user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateReceptionistUser";
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
                cmm.Parameters.Add(new SqlParameter("@receptionistid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "receptionistid", DataRowVersion.Default, null));
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
    }
}
