USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateReceptionistUser]

	--Users 
	@emailAddress				NVARCHAR (256),
	@firstName					NVARCHAR (256),
	@lastName					NVARCHAR (256),

	--UserPassword
	@hash						NVARCHAR (4000),
	@salt						NVARCHAR (256),

	--ContactInfo
	@address					NVARCHAR (255) = NULL,
	@city						NVARCHAR (255) = NULL,
	@country					NVARCHAR (2) = NULL,	
	@state						NVARCHAR (255) = NULL,
	@zip						NVARCHAR (50)  = NULL,
	@phone						NVARCHAR (50)  = NULL,
	@extension					NVARCHAR (20)  = NULL,
	@fax						NVARCHAR (20)  = NULL,

	@roleName					NVARCHAR (200),
	@lastUpdatedBy				INT = NULL,		

	--Hospital Mapping
	@hospitalId				INT,
	
	--Output data
	@userid						INT OUTPUT,
	@userguid					UNIQUEIDENTIFIER OUTPUT,
	@userRoleId					INT OUTPUT,
	@receptionistid				INT OUTPUT
	
	
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION CreateReceptionistUser		
		SET @userid = -1;

		if (not exists (select Email from [Users] where Email = @emailAddress))
		begin
			
			--Create User
			EXEC CreateUser 
			@emailAddress, @firstName, @lastName, @hash, @salt,@address, @city, @country, @state, @zip, @phone, @extension, @fax, 
			@rolename, @lastUpdatedBy, @userId output, @userguid output, @userRoleId output

			set @userid = (SELECT Userid FROM [Users] where Userid = @userid)
			set @userguid = (SELECT UserGUID FROM [Users] where Userid = @userid)
			DECLARE @testsownerid as int
			
			set @testsownerid = (SELECT ReceptionistId from [Receptionist] where UserId = @userid)

			--testOwnerUser
			EXEC [InsertReceptionist] 
			@testsownerid, @hospitalid
			

		end
		else
		begin
			select @userid = UserId from [Users] where Email = @emailAddress
			select @userguid = UserGUID from [Users] where Email = @emailAddress
		end
		
		COMMIT TRANSACTION CreateReceptionistUser
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction CreateReceptionistUser.'
			ROLLBACK TRANSACTION CreateReceptionistUser;
			SET @userId = -1;
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
				'Committing transaction CreateReceptionistUser.'
			COMMIT TRANSACTION CreateReceptionistUser;
		END;
	END CATCH; 
	RETURN @userid
END