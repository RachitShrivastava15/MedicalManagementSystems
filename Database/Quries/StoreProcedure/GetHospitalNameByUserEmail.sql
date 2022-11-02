USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetHospitalNameByUserEmail]

	--Users 
	@emailAddress				NVARCHAR (256)
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION GetHospitalNameByUserEmail		
		
		DECLARE @userid INT
		SET @userid = (SELECT USERid from [Users] where Email = @emailAddress)

		SELECT H.HospitalName FROM Hospital AS H
		INNER JOIN HospitalReceptionistMapping AS HRM
		ON H.HospitalId = HRM.HospitalId
		INNER JOIN Receptionist AS R
		ON R.ReceptionistId = HRM.ReceptionistId
		Inner Join HospitalAdminMapping AS HAM
		ON H.HospitalId = HAM.HospitalId
		Inner JOIN HospitalDoctorMapping AS HDM
		ON H.HospitalId = HDM.HospitalId
		INNER JOIN Doctor AS D
		ON D.DoctorId = HDM.DoctorId
		WHERE R.UserId = @userid
		OR HAM.UserId = @userid
		OR D.UserId = @userid

		COMMIT TRANSACTION GetHospitalNameByUserEmail
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction GetHospitalNameByUserEmail.'
			ROLLBACK TRANSACTION GetHospitalNameByUserEmail;
			 
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
				'Committing transaction GetHospitalNameByUserEmail.'
			COMMIT TRANSACTION GetHospitalNameByUserEmail;
		END;
	END CATCH; 
	
END