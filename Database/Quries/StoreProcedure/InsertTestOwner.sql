USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertTestOwner]

	@testownerid				INT,
	@hospitalid					INT
	


AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertTestOwner			
			
				--SET @testownerid = (SELECT TestOwnerGUID FROM TestOwner WHERE TestOwnerId = @testownerid)

				DECLARE @testownerguid as uniqueidentifier
			
				SELECT 
					   @testownerguid = TestOwnerGUID
					FROM [dbo].[TestOwner]
				WHERE
					TestOwnerId = @testownerid

				DECLARE @hospitalguid as uniqueidentifier
			
				SELECT 
					   @hospitalguid = HospitalGUID
					FROM [dbo].[Hospital]
				WHERE
					HospitalId = @hospitalid
				
				
				
			--Insert Hospital Test Owner mapping
			insert into [HospitalTestOwnerMapping](HospitalId, HospitalGUID, TestOwnerId, TestOwnerGUID, LastUpdateDate)
				values(@hospitalid, @hospitalguid, @testownerid, @testownerguid, GETUTCDATE())
		
		
		COMMIT TRANSACTION InsertTestOwner
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertTestOwner.'
			ROLLBACK TRANSACTION InsertTestOwner;			
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
				'Committing transaction InsertTestOwner.'
			COMMIT TRANSACTION InsertTestOwner;
		END;
	END CATCH; 
	
END