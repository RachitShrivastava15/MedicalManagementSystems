USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BookAppointment]

	 
	@email				NVARCHAR (256),

	@doctoravailablityid	INT =NUll,
	@testavailablityid		INT =NULL,
	@pharamcyavailablityid	INT =NULL,
	@userstateid			INT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION BookAppointment
			
			DECLARE @userid INT, @appointmentid INT

			SET @userid = (SELECT Userid FROM [Users] WHERE Email = @email)

			INSERT INTO Appointment (UserId, DAvailablityId, TAvailablityId, PAvailablityId)
				VALUES (@userid, @doctoravailablityid, @testavailablityid, @pharamcyavailablityid)
			
			SET @appointmentid = (select IDENT_CURRENT('Appointment'))

			INSERT INTO UserStatus (AppointmentId, UserStateId)
				VALUES (@appointmentid, @userstateid)
				
			UPDATE DoctorAvailability
				SET IsAvailable = 0
				WHERE DoctorAvailabilityId = @doctoravailablityid

				UPDATE TestAvailability
				SET IsAvailable = 0
				WHERE TestAvailabilityId = @testavailablityid

				UPDATE PharmacyAvailability
				SET IsAvailable = 0
				WHERE PharmacyAvailabilityId = @pharamcyavailablityid
		
		COMMIT TRANSACTION BookAppointment;
		
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction BookAppointment.'
			ROLLBACK TRANSACTION BookAppointment;
			
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
				'Committing transaction BookAppointment.'
			COMMIT TRANSACTION BookAppointment;
		END;
	END CATCH; 
	
END