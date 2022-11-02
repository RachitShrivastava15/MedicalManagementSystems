USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertReceptionist]

	@receptionistid				INT,
	@hospitalid					INT
	


AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertReceptionist			
			
				--SET @testownerid = (SELECT TestOwnerGUID FROM TestOwner WHERE TestOwnerId = @testownerid)

				DECLARE @receptionistguid as uniqueidentifier
			
				SELECT 
					   @receptionistguid = ReceptionistGUID
					FROM [dbo].[Receptionist]
				WHERE
					ReceptionistId = @receptionistid

				DECLARE @hospitalguid as uniqueidentifier
			
				SELECT 
					   @hospitalguid = HospitalGUID
					FROM [dbo].[Hospital]
				WHERE
					HospitalId = @hospitalid
				
				
				
			--Insert Hospital Receptionist mapping
			insert into [HospitalReceptionistMapping](HospitalId, HospitalGUID, ReceptionistId, ReceptionistGUID, LastUpdateDate)
				values(@hospitalid, @hospitalguid, @receptionistid, @receptionistguid, GETUTCDATE())
		
		
		COMMIT TRANSACTION InsertReceptionist
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertReceptionist.'
			ROLLBACK TRANSACTION InsertReceptionist;			
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
				'Committing transaction InsertReceptionist.'
			COMMIT TRANSACTION InsertReceptionist;
		END;
	END CATCH; 
	
END