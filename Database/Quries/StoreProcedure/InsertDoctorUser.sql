USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertDoctorUser]

	--Doctor	
	@doctorid					INT,
	@doctorguid					UNIQUEIDENTIFIER,

	--Doctor Speciality
	@spcialityid				INT,

	--Hospital Mapping
	@hospitalid				INT	
	

AS
BEGIN
	SET NOCOUNT ON; 
	SET XACT_ABORT ON;
	BEGIN TRY		
		BEGIN TRANSACTION InsertDoctorUser
							
			

			--Insert Doctor Speciality Mapping
			insert into DoctorSpecialityMapping(SpecialityId, DoctorId, DoctorGUID, LastUpdateDate)
				values(@spcialityid, @doctorid, @doctorguid,GETUTCDATE())
				
				DECLARE @hospitalguid as uniqueidentifier
			
				SELECT 
					   @hospitalguid = HospitalGUID
					FROM [dbo].[Hospital]
				WHERE
					HospitalId = @hospitalid

					DECLARE @hospitaldoctorid INT
			--Insert Hospital Doctor Mapping
			insert into [HospitalDoctorMapping](HospitalId, HospitalGUID, DoctorId, DoctorGUID, LastUpdateDate)
				values(@hospitalid, @hospitalguid, @doctorid, @doctorguid, GETUTCDATE())

			set @hospitaldoctorid = (select IDENT_CURRENT('HospitalDoctorMapping'))

			--Insert Doctor Availability 
			insert into [DoctorAvailability](HospitalDoctorId, SlotId, IsAvailable)
				Values(@hospitaldoctorid, 1, 1),
				(@hospitaldoctorid, 2, 1),
				(@hospitaldoctorid, 3, 1),
				(@hospitaldoctorid, 4, 1),
				(@hospitaldoctorid, 5, 1),
				(@hospitaldoctorid, 6, 1),
				(@hospitaldoctorid, 7, 1),
				(@hospitaldoctorid, 8, 1),
				(@hospitaldoctorid, 9, 1),
				(@hospitaldoctorid, 10, 1),
				(@hospitaldoctorid, 11, 1),
				(@hospitaldoctorid, 12, 1),
				(@hospitaldoctorid, 13, 1),
				(@hospitaldoctorid, 14, 1),
				(@hospitaldoctorid, 15, 1),
				(@hospitaldoctorid, 16, 1)
		COMMIT TRANSACTION InsertDoctorUser
	END TRY
	BEGIN CATCH
		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT
				N'The transaction is in an uncommittable state.' +
				'Rolling back transaction InsertDoctorUser.'
			ROLLBACK TRANSACTION InsertDoctorUser;			
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
				'Committing transaction InsertDoctorUser.'
			COMMIT TRANSACTION InsertDoctorUser;
		END;
	END CATCH; 
	
END