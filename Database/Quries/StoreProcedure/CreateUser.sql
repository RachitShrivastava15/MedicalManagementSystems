USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateUser]

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
	--Output data
	@userId						INT OUTPUT,
	@userguid					UNIQUEIDENTIFIER OUTPUT,
	@userRoleId					INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION RegisterUser
		SET @userId = -1;

		if (not exists (select Email from [Users] where Email = @emailAddress))
		begin
			
			--Insert Users
			insert into [Users](Email, FirstName, LastName, CreateDate, LastUpdateDate)
				values(@emailAddress, @firstName, @lastName, GETUTCDATE(), GETUTCDATE())
			set @userId = (select UserId from [Users] where Email = @emailAddress)
			set @userguid = (select UserGUID from [Users] where Email = @emailAddress)

			--Insert User Password
			insert into [UsersPassword](UserId, PasswordHash, PasswordSalt)
				values(@userId, @hash, @salt)

			declare @contactInfoId as int

			--Insert ContactInfo
			insert into [ContactInfo]([Address], City, Country, [State], Zip, Phone, Extension, Fax, ModifiedOn, USERID)
				values(@address, @city, @country, @state, @zip, @phone, @extension, @fax, GETUTCDATE(), @userId)
			set @contactInfoId = (select IDENT_CURRENT('ContactInfo'))			

			declare @userRolesId as int

			DECLARE @roleId as int
			
				SELECT @roleId = RoleId 
					FROM [dbo].[Role]
				WHERE
					Name = @roleName


			--Insert UserRoles
			insert into [UserRoles](UserId, RoleId, LastUpdated, LastUpdatedBy)
				values(@userId, @roleId, GETUTCDATE(), @lastUpdatedBy)

			--Insert UserToRespectiveRole 
			EXEC InsertUserToRespectiveRole
				@roleId, @userId, @userguid, @contactInfoId, @userRoleId output

		end
		else
		begin
			select @userId = UserId from [Users] where Email = @emailAddress
			select @userguid = UserGUID from [Users] where Email = @emailAddress
		end		
		
		COMMIT TRANSACTION RegisterUser
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction CreateUserEx.'
			ROLLBACK TRANSACTION RegisterUserEx;
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
				'Committing transaction CreateUserEx.'
			COMMIT TRANSACTION RegisterUser;
		END;
	END CATCH; 
	RETURN @userId
END