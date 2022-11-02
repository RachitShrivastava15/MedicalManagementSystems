USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertHospitalAdmin]

	--Admin	
	@userid					INT,
	@userGUID				UNIQUEIDENTIFIER,
	
	--Hospital Mapping
	@hospitalid				INT	
	

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertHospitalAdmin
			
			--Insert Hospital Admin Mapping
			
				DECLARE @hospitalguid as uniqueidentifier
			
				SELECT 
					   @hospitalguid = HospitalGUID
					FROM [dbo].[Hospital]
				WHERE
					HospitalId = @hospitalid

			
			insert into [HospitalAdminMapping](HospitalId, HospitalGUID, Userid, UserGUID, LastUpdateDate)
				values(@hospitalid, @hospitalguid, @userid, @userGUID, GETUTCDATE())
		
		
		COMMIT TRANSACTION InsertHospitalAdmin
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertHospitalAdmin.'
			ROLLBACK TRANSACTION InsertHospitalAdmin;			
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
				'Committing transaction InsertHospitalAdmin.'
			COMMIT TRANSACTION InsertHospitalAdmin;
		END;
	END CATCH; 
	
END