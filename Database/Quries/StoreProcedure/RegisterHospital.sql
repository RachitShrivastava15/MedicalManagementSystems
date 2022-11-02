USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[RegisterHospital]

	--Hospital 
	@hospitalname				NVARCHAR (256),	

	--ContactInfo
	@address					NVARCHAR (255) = NULL,
	@city						NVARCHAR (255) = NULL,
	@country					NVARCHAR (2) = NULL,	
	@state						NVARCHAR (255) = NULL,
	@zip						NVARCHAR (50)  = NULL,
	@phone						NVARCHAR (50)  = NULL,
	@extension					NVARCHAR (20)  = NULL,
	@fax						NVARCHAR (20)  = NULL,

	--Output data
	@hospitalId						INT OUTPUT,
	@hospitalguid					UNIQUEIDENTIFIER OUTPUT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION RegisterHospital
		SET @hospitalId = -1;		
			
			--Insert Hospital
			insert into [Hospital](HospitalName, CreateDate, LastUpdateDate)
				values(@hospitalname,  GETUTCDATE(), GETUTCDATE())
			set @hospitalId  = (select IDENT_CURRENT('Hospital'))
			set @hospitalguid = (select HospitalGUID from [Hospital] where HospitalId = @hospitalId)		

			declare @contactInfoId as int

			--Insert ContactInfo
			insert into [ContactInfo]([Address], City, Country, [State], Zip, Phone, Extension, Fax, ModifiedOn, USERID)
				values(@address, @city, @country, @state, @zip, @phone, @extension, @fax, GETUTCDATE(), @hospitalId)
			set @contactInfoId = (select IDENT_CURRENT('ContactInfo'))

			declare @usersContactDetailsId as int

			--Insert HospitalContactDetails
			insert into [HospitalContactDetails](HospitalId, HospitalGUID, ContactInfoId, LastUpdateDate)
				values(@hospitalId, @hospitalguid, @contactInfoId, GETUTCDATE())
			set @usersContactDetailsId = (select IDENT_CURRENT('HospitalContactDetails'))

			declare @countryId as int

			set @countryId = (SELECT Countryid FROM [Country] where CountryISO2 = @country)

			--Insert HospitalCountryMapping
			insert into [HospitalCountryMapping](CountryId, HospitalId, HospitalGUID, LastUpdateDate)
				values(@countryId, @hospitalId, @hospitalguid, GETUTCDATE())	
		
		COMMIT TRANSACTION RegisterHospital;
		
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction RegisterHospital.'
			ROLLBACK TRANSACTION RegisterHospital;
			SET @hospitalId = -1;
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
				'Committing transaction RegisterHospital.'
			COMMIT TRANSACTION RegisterHospital;
		END;
	END CATCH; 
	RETURN @hospitalId
END