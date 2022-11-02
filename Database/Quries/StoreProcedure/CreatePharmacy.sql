USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreatePharmacy]

	--Pharmacy 
	@pharmacyname				NVARCHAR (256),

	--Hospital 
	@hospitalid					INT,	

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
	@pharmacyId						INT OUTPUT,
	@pharmacyguid					UNIQUEIDENTIFIER OUTPUT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION CreatePharmacy
		SET @pharmacyId = -1;		
			
			--Insert Pharmacy
			insert into [Pharmacy](PharmacyName, CreateDate, LastUpdateDate)
				values(@pharmacyname,  GETUTCDATE(), GETUTCDATE())
			set @pharmacyId  = (select IDENT_CURRENT('Pharmacy'))
			set @pharmacyguid = (select PharmacyGUID from [Pharmacy] where PharmacyId = @pharmacyId)		

			declare @contactInfoId as int

			--Insert ContactInfo
			insert into [ContactInfo]([Address], City, Country, [State], Zip, Phone, Extension, Fax, ModifiedOn, UserId)
				values(@address, @city, @country, @state, @zip, @phone, @extension, @fax, GETUTCDATE(), @pharmacyId)
			set @contactInfoId = (select IDENT_CURRENT('ContactInfo'))

			declare @usersContactDetailsId as int

			--Insert PharmacyContactDetails
			insert into [PharmacyContactDetails](PharmacyId, PharmacyGUID, ContactInfoId, LastUpdateDate)
				values(@pharmacyId, @pharmacyguid, @contactInfoId, GETUTCDATE())
			set @usersContactDetailsId = (select IDENT_CURRENT('PharmacyContactDetails'))
			
			declare @hospitalguid UNIQUEIDENTIFIER

			set @hospitalguid = (SELECT HospitalGUID FROM [Hospital] WHERE HospitalId = @hospitalid)

			declare @hospitalpharmacymappingid INT
			--Insert HospitalPharmacyMapping
			insert into [HospitalPharmacyMapping](PharmacyId, PharmacyGUID, HospitalId, HospitalGUID, LastUpdateDate)
				values(@pharmacyId, @pharmacyguid, @hospitalId, @hospitalguid, GETUTCDATE())	
			
			set @hospitalpharmacymappingid = (select IDENT_CURRENT('HospitalPharmacyMapping'))
			insert into [PharmacyAvailability](HospitalPharmacyId, SlotId, IsAvailable)
				Values(@hospitalpharmacymappingid, 1, 1),
				(@hospitalpharmacymappingid, 2, 1),
				(@hospitalpharmacymappingid, 3, 1),
				(@hospitalpharmacymappingid, 4, 1),
				(@hospitalpharmacymappingid, 5, 1),
				(@hospitalpharmacymappingid, 6, 1),
				(@hospitalpharmacymappingid, 7, 1),
				(@hospitalpharmacymappingid, 8, 1),
				(@hospitalpharmacymappingid, 9, 1),
				(@hospitalpharmacymappingid, 10, 1),
				(@hospitalpharmacymappingid, 11, 1),
				(@hospitalpharmacymappingid, 12, 1),
				(@hospitalpharmacymappingid, 13, 1),
				(@hospitalpharmacymappingid, 14, 1),
				(@hospitalpharmacymappingid, 15, 1),
				(@hospitalpharmacymappingid, 16, 1)
			
		COMMIT TRANSACTION CreatePharmacy;
		
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction CreatePharmacy.'
			ROLLBACK TRANSACTION CreatePharmacy;
			SET @pharmacyId = -1;
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
				'Committing transaction CreatePharmacy.'
			COMMIT TRANSACTION CreatePharmacy;
		END;
	END CATCH; 
	RETURN @pharmacyId
END