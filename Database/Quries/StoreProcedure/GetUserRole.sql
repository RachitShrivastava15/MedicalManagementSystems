USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserRole]
	 
	@email				NVARCHAR (256)
	
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION GetUserRole
			
			SELECT R.RoleId, R.Name FROM UserRoles AS UR
				INNER JOIN Users AS U
				ON UR.UserId = U.UserId
				INNER JOIN [ROLE] AS R
				ON UR.RoleId = R.RoleId
					WHERE U.Email = @email
		
		
		COMMIT TRANSACTION GetUserRole;
		
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction GetUserRole.'
			ROLLBACK TRANSACTION GetUserRole;
			
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
				'Committing transaction GetUserRole.'
			COMMIT TRANSACTION GetUserRole;
		END;
	END CATCH; 
	
END