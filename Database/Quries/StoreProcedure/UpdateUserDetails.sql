USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[UpdateUserDetails]

	--Users 
	@emailaddress				NVARCHAR (256),
	@firstName					NVARCHAR (256),
	@lastName					NVARCHAR (256),

	
	--ContactInfo
	@address					NVARCHAR (255),
	@city						NVARCHAR (255),
	@country					NVARCHAR (2),	
	@state						NVARCHAR (255),
	@zip						NVARCHAR (50),
	@phone						NVARCHAR (50),
	@extension					NVARCHAR (20),
	@fax						NVARCHAR (20)

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION UpdateUserDetails
		
		DECLARE @userid INT
		SET @userid = (SELECT USERID FROM [Users] WHERE Email = @emailaddress)
		
		UPDATE ContactInfo
		SET Address = @address,
			City = @city,
			Country = @country,
			State = @state,
			Zip = @zip,
			Phone = @phone,
			Extension = @extension,
			Fax = @fax,
			ModifiedOn = GETUTCDATE()
		WHERE USERID = @userid 
		
				
		
		COMMIT TRANSACTION UpdateUserDetails
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction UpdateUserDetails.'
			ROLLBACK TRANSACTION UpdateUserDetails;
			
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
				'Committing transaction UpdateUserDetails.'
			COMMIT TRANSACTION UpdateUserDetails;
		END;
	END CATCH; 
	
END