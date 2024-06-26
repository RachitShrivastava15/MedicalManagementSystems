USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetDoctorAvailabilityByHospital]

	@hospitalname			NVARCHAR(256),
	@doctorid				INT


AS
BEGIN
	
		BEGIN TRANSACTION GetDoctorAvailabilityByHospital
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)
			
			SELECT S.SlotTime, DA.IsAvailable, DA.DoctorAvailabilityId FROM HospitalDoctorMapping AS HD
					INNER JOIN DoctorAvailability AS DA
					ON HD.HospitalDoctorId = DA.HospitalDoctorId
					INNER JOIN Slots AS S
					ON S.SlotId = DA.SlotId
							WHERE HD.HospitalId = @hospitalid 
							  AND HD.DoctorId = @doctorid
							  AND DA.IsAvailable = 1
			

		
		
		COMMIT TRANSACTION GetDoctorAvailabilityByHospital
	 
	 END