USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserAppointmentHistory]

	--Users 
	@emailAddress				NVARCHAR (256)
	
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION GetUserAppointmentHistory
		
		SELECT US.AppointmentId, US.UserStateId, U.UserId FROM UserStatus AS US
		INNER JOIN Appointment AS A
		ON US.AppointmentId = A.AppointmentId
		INNER JOIN Users AS U
		ON A.UserId = U.UserId
		WHERE U.Email = @emailaddress
			AND US.UserStateId = 10
		
		COMMIT TRANSACTION GetUserAppointmentHistory
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction GetUserAppointmentHistory.'
			ROLLBACK TRANSACTION GetUserAppointmentHistory;
			
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
				'Committing transaction GetUserAppointmentHistory.'
			COMMIT TRANSACTION GetUserAppointmentHistory;
		END;
	END CATCH; 

END