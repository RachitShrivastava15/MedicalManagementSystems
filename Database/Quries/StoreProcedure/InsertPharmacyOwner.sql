USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertPharmacyOwner]

	--Admin	
	@userid					INT,
	
	
	--Pharmacy
	@pharmacyid				INT,
	
	@pharmacyownerid		INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertPharmacyOwner			
			
				SET @pharmacyownerid = (SELECT PharmacyOwnerId FROM PharmacyOwner WHERE UserId = @userid)

				DECLARE @pharmacyownerguid as uniqueidentifier
			
				SELECT 
					   @pharmacyownerguid = PharmacyOwnerGUID
					FROM [dbo].[PharmacyOwner]
				WHERE
					PharmacyOwnerId = @pharmacyownerid

				DECLARE @pharmacyguid as uniqueidentifier
				SELECT 
					   @pharmacyguid = PharmacyGUID
					FROM [dbo].[Pharmacy]
				WHERE
					PharmacyId = @pharmacyid
			--Insert Pharmacy Owner mapping
			insert into [PharmacyOwnerMapping](PharmacyId, PharmacyGUID, PharmacyOwnerId, PharmacyOwnerGUID, LastUpdateDate)
				values(@pharmacyid, @pharmacyguid, @pharmacyownerid, @pharmacyownerguid, GETUTCDATE())
		
		
		COMMIT TRANSACTION InsertPharmacyOwner
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertPharmacyOwner.'
			ROLLBACK TRANSACTION InsertPharmacyOwner;			
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
				'Committing transaction InsertPharmacyOwner.'
			COMMIT TRANSACTION InsertPharmacyOwner;
		END;
	END CATCH; 
	
END