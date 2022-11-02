USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDoctorListByHospital]

	@hospitalname			NVARCHAR(256)	


AS
BEGIN
	
		BEGIN TRANSACTION GetDoctorListByHospital
		
		DECLARE @hospitalid INT, @doctorid INT, @specialityid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)
			
			SELECT 
			U.Email, U.FirstName, U.LastName, S.SpecialityName,D.DoctorId 
			
			FROM [HospitalDoctorMapping] AS HD
				INNER JOIN Doctor AS D
				ON HD.DoctorId = D.DoctorId
				INNER JOIN Users AS U
				ON D.UserId = U.UserId
				Inner JOIN DoctorSpecialityMapping AS SD
				ON SD.DoctorId = D.DoctorId
				INNER JOIN Speciality AS S
				ON S.SpecialityId = SD.SpecialityId
							WHERE HD.HospitalId = @hospitalid 
			

		
		
		COMMIT TRANSACTION GetDoctorListByHospital
	 
	 END