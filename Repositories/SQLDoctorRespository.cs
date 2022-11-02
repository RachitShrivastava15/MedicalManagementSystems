using MedicalManagementSystem.Helpers;
using MedicalManagementSystem.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Internal;
using System;
using System.Collections.Generic;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public class SQLDoctorRespository : IDoctorRespository
    {
        private readonly AppDbContext context;
        
       
        private HashSalt hashSalt = new HashSalt();

        public SQLDoctorRespository(AppDbContext context)
        {
            this.context = context;
            
        }

        public bool RegisterDoctor(Speciality user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreateDoctorUser";
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
                cmm.Parameters.Add(new SqlParameter("@spcialityname", user.SpecialityName));
                cmm.Parameters.Add(new SqlParameter("@hospitalName", user.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@userid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userguid", SqlDbType.UniqueIdentifier, 32, ParameterDirection.Output, false, 0, 20, "userguid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userRoleId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userRoleId", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@doctorid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "doctorid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@doctorguid", SqlDbType.UniqueIdentifier, 32, ParameterDirection.Output, false, 0, 20, "doctorguid", DataRowVersion.Default, null));
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

        public List<Speciality> GetSpecialityList()
        {

            List<Speciality> specialityList = new List<Speciality>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetSpecialityList";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Speciality speciality = new Speciality();
                    speciality.SpecialityId = Convert.ToString(results["SpecialityId"]);
                    speciality.SpecialityName = Convert.ToString(results["SpecialityName"]);

                    specialityList.Add(speciality);
                    i++;
                    
                }

            }

            return specialityList;
        }

        public List<Doctor> GetDoctorAvailabilityList(Hospital hospital)
        {

            List<Doctor> doctorList = new List<Doctor>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetDoctorAvailabilityByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@doctorid", hospital.DoctorId));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Doctor doctor = new Doctor();
                    doctor.SlotTime = Convert.ToString(results["SlotTime"]);
                    doctor.IsAvailable = Convert.ToString(results["IsAvailable"]);
                    doctor.DoctorAvailabilityId = Convert.ToString(results["DoctorAvailabilityId"]);
                    doctorList.Add(doctor);
                    i++;

                }

            }

            return doctorList;
        }

        public List<Country> GetCountry()
        {
            SQLCountryRepository sqlCountryRepository = new SQLCountryRepository(context);

            List<Country> countryList = sqlCountryRepository.GetCountry();
            //List<Country> countryList = new List<Country>();
            
            //using (var cnn = context.Database.GetDbConnection())
            //{
                
            //    var cmm = cnn.CreateCommand();
            //    cmm.CommandType = CommandType.StoredProcedure;
            //    cmm.CommandText = "GetCountries";
            //    cmm.Connection = cnn;
            //    cnn.Open();
            //    var results = cmm.ExecuteReader();
            //    int i = 0;
            //    while (results.Read())
            //    {
            //        Country finalCountry = new Country();
            //        finalCountry.CountryISO2 = Convert.ToString(results["CountryISO2"]);
            //        finalCountry.CountryName = Convert.ToString(results["CountryName"]);

            //        countryList.Add(finalCountry);
            //        i++;

            //    }

            //}

            return countryList;

        }

        public bool RegisterHospital(Hospital hospital)
        {
            SQLHospitalRepository hospitalRepository = new SQLHospitalRepository(context);
            bool success = hospitalRepository.RegisterHospital(hospital);
            if (success)
                return true;
            else
                return false;
        }

        public List<Hospital> GetHospitalList()
        {
            SQLHospitalRepository hospitalRepository = new SQLHospitalRepository(context);
            List<Hospital> hospitals = hospitalRepository.GetHospitalList();

            return hospitals;
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

        public bool RegisterAdminUser(Hospital hospital)
        {
            throw new NotImplementedException();
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
