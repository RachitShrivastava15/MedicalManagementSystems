USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllUsers]

	
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION GetAllUsers		
		
		SELECT U.Email FROM [Users] AS U
		INNER JOIN Patient AS P
		ON U.UserId = P.UserId

		COMMIT TRANSACTION GetAllUsers
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction GetAllUsers.'
			ROLLBACK TRANSACTION GetAllUsers;
			 
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
				'Committing transaction GetAllUsers.'
			COMMIT TRANSACTION GetAllUsers;
		END;
	END CATCH; 
	
END