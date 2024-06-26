USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertUserToRespectiveRole]

	@roleId						INT,
	--Doctor
	@userId						INT,	
	--Patient
	@userguid					UNIQUEIDENTIFIER,
	--ContactInfo
	@contactInfoId				INT,
	--Output data
	@userRoleId						INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertUserToRespectiveRole
		SET @userRoleId = -1

		if (@roleId = 3)
		begin			
			--Insert Doctor
			insert into [Doctor](CreateDate, LastUpdateDate, UserId)
				values(GETUTCDATE(), GETUTCDATE(), @userId)
			SET @userRoleId = (select IDENT_CURRENT('Doctor'))

			DECLARE @doctorid INT, @doctorguid UNIQUEIDENTIFIER 
			SET @doctorid = (SELECT DoctorId FROM [Doctor] where UserId = @userId)
			SET @doctorguid = (SELECT DoctorGUID FROM [Doctor] where UserId = @userId)
			
			--Insert Doctor Contact Details
			insert into [DoctorContactDetails](DoctorId, DoctorGUID, ContactInfoId, LastUpdateDate)
				values(@doctorid, @doctorguid, @contactInfoId, GETUTCDATE())

		end
		else
		if (@roleId = 6)
		begin
			--Insert Patient
			insert into [Patient](UserId, UserGUID, LastUpdateDate, CreateDate)
				values(@userId, @userguid, GETUTCDATE(), GETUTCDATE())
			SET @userRoleId = (select IDENT_CURRENT('Patient'))

			declare @usersContactDetailsId as int

			--Insert UserConatctDetails
			insert into [UsersContactDetails](UserId, UserGUID, ContactInfoId, LastUpdateDate)
				values(@userId, @userguid, @contactInfoId, GETUTCDATE())
			set @usersContactDetailsId = (select IDENT_CURRENT('UsersContactDetails'))
		end		
		else
		if (@roleId = 4)
		begin
			--Insert PharmacyOwner
			insert into [PharmacyOwner](UserId, LastUpdateDate, CreateDate)
				values(@userId, GETUTCDATE(), GETUTCDATE())
			SET @userRoleId = (select IDENT_CURRENT('PharmacyOwner'))			
			declare @pharmacyguid as UNIQUEIDENTIFIER 
			SET @pharmacyguid = (SELECT PharmacyOwnerGUID from PharmacyOwner where PharmacyOwnerId = @userRoleId)

			--Insert UserConatctDetails
			--insert into [UsersContactDetails](UserId, UserGUID, ContactInfoId, LastUpdateDate)
			--	values(@userRoleId, @pharmacyguid, @contactInfoId, GETUTCDATE())
			
		end		
		else
		if (@roleId = 5)
		begin
			--Insert Receptionist
			insert into [Receptionist](UserId, LastUpdateDate, CreateDate)
				values(@userId, GETUTCDATE(), GETUTCDATE())
			SET @userRoleId = (select IDENT_CURRENT('Receptionist'))
			declare @receptionistguid as UNIQUEIDENTIFIER 
			SET @receptionistguid = (SELECT ReceptionistGUID from Receptionist where ReceptionistId = @userRoleId)

			--Insert UserConatctDetails
			insert into [ReceptionistContactDetails](ReceptionistId, ReceptionistGUID, ContactInfoId, LastUpdateDate)
				values(@userRoleId, @receptionistguid, @contactInfoId, GETUTCDATE())

		end		
		if (@roleId = 7)
		begin
			--Insert TestOwner
			insert into [TestOwner](UserId, LastUpdateDate, CreateDate)
				values(@userId, GETUTCDATE(), GETUTCDATE())
			SET @userRoleId = (select IDENT_CURRENT('TestOwner'))

			declare @testguid as UNIQUEIDENTIFIER 
			SET @testguid = (SELECT TestOwnerGUID from TestOwner where TestOwnerId = @userRoleId)

			--Insert UserConatctDetails
			insert into [TestOwnerContactDetails](TestOwnerId, TestOwnerGUID, ContactInfoId, LastUpdateDate)
				values(@userRoleId, @testguid, @contactInfoId, GETUTCDATE())
		end			
		COMMIT TRANSACTION InsertUserToRespectiveRole
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertUserToRespectiveRole.'
			ROLLBACK TRANSACTION InsertUserToRespectiveRole;
			SET @userRoleId = -1;
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
			COMMIT TRANSACTION InsertUserToRespectiveRole;
		END;
	END CATCH; 
	RETURN @userRoleId
END