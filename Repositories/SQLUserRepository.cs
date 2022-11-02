using MedicalManagementSystem.Helpers;
using MedicalManagementSystem.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace MedicalManagementSystem.Repositories
{
    public class SQLUserRepository : IUserRespository
    {
        private readonly AppDbContext context;
        private HashSalt hashSalt = new HashSalt();

        public SQLUserRepository(AppDbContext context)
        {
            this.context = context;
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

        public User UserRoles(User user)
        {
            User userRole = new User();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetUserRole";
                cmm.Parameters.Add(new SqlParameter("@email", user.Email));                
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();
                
                while (results.Read())
                {


                    userRole.RoleId = Convert.ToString(results["RoleId"]);
                    userRole.RoleName = Convert.ToString(results["Name"]);
                    
                   
                }
                return userRole;
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
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
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

        public bool BookAppointment(Tests user)
        {
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "BookAppointment";
                cmm.Parameters.Add(new SqlParameter("@email", user.UserEmail));
                cmm.Parameters.Add(new SqlParameter("@doctoravailablityid", user.DoctorAvailabilityId));
                cmm.Parameters.Add(new SqlParameter("@testavailablityid", user.TestAvailabilityId));
                cmm.Parameters.Add(new SqlParameter("@pharamcyavailablityid", user.PharmacyAvailabilityId));
                cmm.Parameters.Add(new SqlParameter("@userstateid", 1));
                cmm.Connection = cnn;
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cnn.Open();
                var results = cmm.ExecuteReader();
                cnn.Close();
                if (results != null)
                {
                    return true;
                }
                else
                    return false;
            }
        }

        public User UserContactDetails(User user)
        {
            User userDeatils = new User();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GETPatientContactDetails";
                cmm.Parameters.Add(new SqlParameter("@email", user.Email));
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                while (results.Read())
                {
                    userDeatils.Email = Convert.ToString(results["Email"]);
                    userDeatils.FirstName = Convert.ToString(results["FirstName"]);
                    userDeatils.LastName = Convert.ToString(results["LastName"]);
                    userDeatils.Address = Convert.ToString(results["Address"]);
                    userDeatils.City = Convert.ToString(results["City"]);
                    userDeatils.Country = Convert.ToString(results["Country"]);
                    userDeatils.Extension = Convert.ToString(results["Extension"]);
                    userDeatils.Fax = Convert.ToString(results["Fax"]);
                    userDeatils.Phone = Convert.ToString(results["Phone"]);
                    userDeatils.State = Convert.ToString(results["State"]);
                    userDeatils.Zip = Convert.ToString(results["Zip"]);
                }
                return userDeatils;
            }
        }

        public User DoctorContactDetails(User user)
        {
            User userDeatils = new User();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GETDoctorContactDetails";
                cmm.Parameters.Add(new SqlParameter("@doctorid", user.DoctorId));
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                while (results.Read())
                {
                    userDeatils.Email = Convert.ToString(results["Email"]);
                    userDeatils.FirstName = Convert.ToString(results["FirstName"]);
                    userDeatils.LastName = Convert.ToString(results["LastName"]);
                    userDeatils.Address = Convert.ToString(results["Address"]);
                    userDeatils.City = Convert.ToString(results["City"]);
                    userDeatils.Country = Convert.ToString(results["Country"]);
                    userDeatils.Extension = Convert.ToString(results["Extension"]);
                    userDeatils.Fax = Convert.ToString(results["Fax"]);
                    userDeatils.Phone = Convert.ToString(results["Phone"]);
                    userDeatils.State = Convert.ToString(results["State"]);
                    userDeatils.Zip = Convert.ToString(results["Zip"]);
                }
                return userDeatils;
            }
        }


        public User HospitalContactDetails(User user)
        {
            User userDeatils = new User();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GETHospitalContactDetails";
                cmm.Parameters.Add(new SqlParameter("@hospitalname", user.HospitalName));
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                while (results.Read())
                {
                    
                    userDeatils.Address = Convert.ToString(results["Address"]);
                    userDeatils.City = Convert.ToString(results["City"]);
                    userDeatils.Country = Convert.ToString(results["Country"]);
                    userDeatils.Extension = Convert.ToString(results["Extension"]);
                    userDeatils.Fax = Convert.ToString(results["Fax"]);
                    userDeatils.Phone = Convert.ToString(results["Phone"]);
                    userDeatils.State = Convert.ToString(results["State"]);
                    userDeatils.Zip = Convert.ToString(results["Zip"]);
                }
                return userDeatils;
            }
        }

        public List<User> ActiveAppoinmentUserList(User user)
        {
            List<User> userlist = new List<User>();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetUserAppointment";
                cmm.Parameters.Add(new SqlParameter("@email", user.Email));
                cmm.Parameters.Add(new SqlParameter("@userstate", user.UserState));
                cmm.Parameters.Add(new SqlParameter("@loginid", user.LoginId));
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                while (results.Read())
                {
                    User user1 = new User();
                    user1.AppointmentId = Convert.ToString(results["AppointmentId"]);
                    user1.UserState = Convert.ToString(results["UserStateId"]);
                    user1.Email = Convert.ToString(results["Email"]);
                    user1.FirstName = Convert.ToString(results["FirstName"]);
                    user1.LastName = Convert.ToString(results["LastName"]);
                    userlist.Add(user1);
                    i++;
                }
                return userlist;
            }
        }

        public bool UpdateUserStatus(User user)
        {
            
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "UpdateUserAppointment";
                cmm.Parameters.Add(new SqlParameter("@appointmentid", user.AppointmentId));
                cmm.Parameters.Add(new SqlParameter("@userstate", user.UserState));                
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();

                
                 return true;
               
            }
        }

        public List<User> AllListOfPatientUser()
        {
            List<User> userList = new List<User>();

            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "GetAllUsers";
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;                
                cnn.Open();
                var results = cmm.ExecuteReader();
                int i = 0;
                //need to fix here
                while (results.Read())
                {
                    User finaluser = new User();
                    finaluser.Email = Convert.ToString(results["Email"]);

                    userList.Add(finaluser);
                    i++;

                }

            }
            return userList;
        }

        public bool UpdateUserProfile(User user)
        {
            User userDeatils = new User();
            using (var cnn = context.Database.GetDbConnection())
            {
                var cmm = cnn.CreateCommand();
                cmm.CommandType = CommandType.StoredProcedure;
                cmm.CommandText = "UpdateUserDetails";
                cmm.Parameters.Add(new SqlParameter("@emailaddress", user.Email));
                cmm.Parameters.Add(new SqlParameter("@firstname", user.FirstName));
                cmm.Parameters.Add(new SqlParameter("@lastname", user.LastName));
                cmm.Parameters.Add(new SqlParameter("@address", user.Address));
                cmm.Parameters.Add(new SqlParameter("@city", user.City));
                cmm.Parameters.Add(new SqlParameter("@country", user.Country));
                cmm.Parameters.Add(new SqlParameter("@extension", user.Extension));
                cmm.Parameters.Add(new SqlParameter("@fax", user.Fax));
                cmm.Parameters.Add(new SqlParameter("@phone", user.Phone));
                cmm.Parameters.Add(new SqlParameter("@state", user.State));
                cmm.Parameters.Add(new SqlParameter("@zip", user.Zip));
                cnn.ConnectionString = Connection.Configuration.GetValue<string>("Database:App:appDB");
                cmm.Connection = cnn;
                cnn.Open();
                var results = cmm.ExecuteReader();
               
                return true;
            }
        }
    }
}
