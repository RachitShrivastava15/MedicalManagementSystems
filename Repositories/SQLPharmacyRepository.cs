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
    public class SQLPharmacyRepository : IPharmacyRespository
    {

        private readonly AppDbContext context;

        public SQLPharmacyRepository(AppDbContext context)
        {
            this.context = context;

        }

        public bool RegisterPharmacy(Pharmacy pharmacy)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreatePharmacy";
                cmm.Parameters.Add(new SqlParameter("@pharmacyname", pharmacy.PharmacyName));
                cmm.Parameters.Add(new SqlParameter("@hospitalid", pharmacy.HospitalId));
                cmm.Parameters.Add(new SqlParameter("@address", pharmacy.Address));
                cmm.Parameters.Add(new SqlParameter("@city", pharmacy.City));
                cmm.Parameters.Add(new SqlParameter("@country", pharmacy.Country));
                cmm.Parameters.Add(new SqlParameter("@state", pharmacy.State));
                cmm.Parameters.Add(new SqlParameter("@zip", pharmacy.Zip));
                cmm.Parameters.Add(new SqlParameter("@phone", pharmacy.Phone));
                cmm.Parameters.Add(new SqlParameter("@extension", pharmacy.Extension));
                cmm.Parameters.Add(new SqlParameter("@fax", pharmacy.Fax));
                cmm.Parameters.Add(new SqlParameter("@pharmacyId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "pharmacyId", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@pharmacyguid", SqlDbType.UniqueIdentifier, 256, ParameterDirection.Output, false, 0, 20, "@pharmacyguid", DataRowVersion.Default, null));
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
            throw new NotImplementedException();
        }

        public List<Hospital> GetHospitalList()
        {
            throw new NotImplementedException();
        }

        public bool RegisterAdminUser(Hospital hospital)
        {
            throw new NotImplementedException();
        }

        public bool RegisterHospital(Hospital hospital)
        {
            throw new NotImplementedException();
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

        public List<Pharmacy> GetPharmacyList()
        {
            List<Pharmacy> pharmacyList = new List<Pharmacy>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetPharmacyList";
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Pharmacy finalPharmacy = new Pharmacy();
                    finalPharmacy.PharmacyId = Convert.ToString(results["PharmacyId"]);
                    finalPharmacy.PharmacyName = Convert.ToString(results["PharmacyName"]);

                    pharmacyList.Add(finalPharmacy);
                    i++;

                }

            }

            return pharmacyList;
        }

        public bool RegisterPharmacyownerUser(Pharmacy user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                HashSalt hashSalt = new HashSalt();
                HashSalt finalPassword = hashSalt.GenerateSaltedHash(user.Password);
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "CreatePharmacyOwnerUser";
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
                cmm.Parameters.Add(new SqlParameter("@pharmacyId", user.PharmacyId));
                cmm.Parameters.Add(new SqlParameter("@userid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userguid", SqlDbType.UniqueIdentifier, 32, ParameterDirection.Output, false, 0, 20, "userguid", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@userRoleId", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "userRoleId", DataRowVersion.Default, null));
                cmm.Parameters.Add(new SqlParameter("@pharmacyownerid", SqlDbType.Int, 32, ParameterDirection.Output, false, 0, 20, "pharmacyownerid", DataRowVersion.Default, null));
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



            return true;
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

        public List<Pharmacy> GetPharmacyAvailabilityList(Hospital hospital)
        {

            List<Pharmacy> pharmacyList = new List<Pharmacy>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetPharmacyAvailabilityByHospital";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", hospital.HospitalName));
                cmm.Parameters.Add(new SqlParameter("@pharmacyid", hospital.PharamcyId));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    Pharmacy pharmacy = new Pharmacy();
                    pharmacy.SlotTime = Convert.ToString(results["SlotTime"]);
                    pharmacy.IsAvailable = Convert.ToString(results["IsAvailable"]);
                    pharmacy.PharmacyAvailabilityId = Convert.ToString(results["PharmacyAvailabilityId"]);
                    pharmacyList.Add(pharmacy);
                    i++;

                }

            }

            return pharmacyList;
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
