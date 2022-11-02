USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateTests]

	--Tests 
	@testsname				NVARCHAR (256),	

	--Hospital
	@hospitalid				INT,
	--Output data
	@testsId						INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION CreateTests
		SET @testsId = -1;		
			
			if (not exists (select TestsName from [Tests] where TestsName = @testsname))
			begin
			--Insert Tests
			insert into [Tests](TestsName, CreateDate, LastUpdateDate)
				values(@testsname,  GETUTCDATE(), GETUTCDATE())
			set @testsId  = (select IDENT_CURRENT('Tests'))

			DECLARE @testguid as Uniqueidentifier
			set @testguid = (select TestsGUID from [Tests] where TestsId = @testsId)	
			end	
			else
		begin
			select @testsId = TestsId from [Tests] where TestsId = @testsId
			select @testguid = TestsGUID from [Tests] where TestsId = @testsId
		end		
			--Insert HospitalTestsMapping
			DECLARE @hospitalguid as Uniqueidentifier, @hospitaltestid as INT
			set @hospitalguid = (select HospitalGUID from [Hospital] where HospitalId = @hospitalid)	
			insert into [HospitalTestsMapping] (HospitalId, HospitalGUID, TestsId, TestsGUID, LastUpdateDate)
				values(@hospitalid, @hospitalguid, @testsId, @testguid, GETUTCDATE())
				set @hospitaltestid  = (select IDENT_CURRENT('HospitalTestsMapping'))
				insert into [TestAvailability](HospitalTestId, SlotId, IsAvailable)
				Values(@hospitaltestid, 1, 1),
				(@hospitaltestid, 2, 1),
				(@hospitaltestid, 3, 1),
				(@hospitaltestid, 4, 1),
				(@hospitaltestid, 5, 1),
				(@hospitaltestid, 6, 1),
				(@hospitaltestid, 7, 1),
				(@hospitaltestid, 8, 1),
				(@hospitaltestid, 9, 1),
				(@hospitaltestid, 10, 1),
				(@hospitaltestid, 11, 1),
				(@hospitaltestid, 12, 1),
				(@hospitaltestid, 13, 1),
				(@hospitaltestid, 14, 1),
				(@hospitaltestid, 15, 1),
				(@hospitaltestid, 16, 1)


		COMMIT TRANSACTION CreateTests;
		
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction CreateTests.'
			ROLLBACK TRANSACTION CreateTests;
			SET @testsId = -1;
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
				'Committing transaction CreateTests.'
			COMMIT TRANSACTION CreateTests;
		END;
	END CATCH; 
	RETURN @testsId
END