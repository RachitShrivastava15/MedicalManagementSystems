USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserAppointment]

	--Users 
	@email				NVARCHAR(256),
	@userstate					INT,
	@loginid					INT
	
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION GetUserAppointment
		
		DECLARE @hospitalid INT, @receptionistid INT
		If @loginid = 1
		SELECT @hospitalid = HRM.HospitalId FROM HospitalReceptionistMapping AS HRM
		INNER JOIN [Receptionist] AS R
		ON HRM.ReceptionistId = R.ReceptionistId 
		INNER JOIN [USERS] AS U
		ON R.UserId = U.UserId
		WHERE U.Email = @email
		
		If @loginid = 2
		SELECT @hospitalid = HRM.HospitalId FROM HospitalDoctorMapping AS HRM
		INNER JOIN [Doctor] AS D
		ON HRM.DoctorId = D.DoctorId 
		INNER JOIN [USERS] AS U
		ON D.UserId = U.UserId
		WHERE U.Email = @email

		If @loginid = 3
		SELECT @hospitalid = HRM.HospitalId FROM HospitalPharmacyMapping AS HRM
		INNER JOIN [PharmacyOwner] AS PO
		ON HRM.PharmacyId = PO.PharmacyOwnerId
		INNER JOIN [USERS] AS U
		ON PO.UserId = U.UserId
		WHERE U.Email = @email

		If @loginid = 4
		SELECT @hospitalid = HRM.HospitalId FROM HospitalTestOwnerMapping AS HRM
		INNER JOIN [TestOwner] AS T
		ON HRM.TestOwnerId = T.TestOwnerId
		INNER JOIN [USERS] AS U
		ON T.UserId = U.UserId
		WHERE U.Email = @email

		--Else
		--SELECT @hospitalid = HRM.HospitalId FROM AS HRM
		--INNER JOIN [Receptionist] AS R
		--ON HRM.ReceptionistId = R.ReceptionistId 
		--INNER JOIN [USERS] AS U
		--ON R.UserId = U.UserId
		--WHERE U.Email = @email

		DECLARE @userid INT, @appointmentid INT

		SELECT A.AppointmentId,
			   US.UserStateId,
			   U.Email, U.FirstName, U.LastName
		FROM Appointment AS A
		INNER JOIN UserStatus AS US
		ON US.AppointmentId = A.AppointmentId
		Full JOIN DoctorAvailability AS DA
		ON A.DAvailablityId = DA.DoctorAvailabilityId
		FULL JOIN HospitalDoctorMapping AS HDM
		ON DA.HospitalDoctorId = HDM.HospitalDoctorId
		FULL JOIN PharmacyAvailability AS PA
		ON PA.PharmacyAvailabilityId = A.PAvailablityId
		FULL JOIN HospitalPharmacyMapping AS HPM
		ON HPM.HospitalPharmacyId = PA.HospitalPharmacyId	
		FULL JOIN TestAvailability AS TA
		ON A.TAvailablityId = TA.TestAvailabilityId
		FULL JOIN HospitalTestsMapping AS HTM
		ON HTM.HospitalTestId = TA.HospitalTestId			
		INNER JOIN USERS U
		ON U.UserId = A.UserId
		WHERE 
		US.UserStateId = @userstate
		AND HDM.HospitalId = @hospitalid
		OR HPM.HospitalId = @hospitalid
		OR HTM.HospitalId = @hospitalid
		 

		--SELECT * FROM UserStatus
		--WHERE AppointmentId = @appointmentid

		--PRINT @hospitalid
		--PRINT @receptionistid

		--SELECT US.AppointmentId, US.UserStateId FROM UserStatus AS US
		--	WHERE US.AppointmentId = @appointmentid
		--		AND US.UserStateId = @userstate
		
		
		COMMIT TRANSACTION GetUserAppointment
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction GetUserAppointment.'
			ROLLBACK TRANSACTION GetUserAppointment;
			
			DECLARE @ErrorMessage NVARCHAR(4000); 
			DECLARE @ErrorSeverity INT; 
			DECLARE @ErrorState INT;  

			SELECT @ErrorMessage = ERROR_MESSAGE(), 
				   @ErrorSeverity = ERROR_SEVERITY(), 
				   @ErrorState = ERROR_STATE(); 
		                       
			RAISERROR (@ErrorMessage, -- Message text. 
					   @ErrorSeverity, -- Severity. 
					   @ErrorState -- State. 
					   );
		END;
		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
			PRINT
				N'The transaction is committable.' +
				'Committing transaction GetUserAppointment.'
			COMMIT TRANSACTION GetUserAppointment;
		END;
	END CATCH; 

END