USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyAvailabilityByHospital]

	@hospitalname			NVARCHAR(256),
	@pharmacyid				INT


AS
BEGIN
	
		BEGIN TRANSACTION GetPharmacyAvailability
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)
			
			SELECT S.SlotTime, PA.IsAvailable, PA.PharmacyAvailabilityId FROM HospitalPharmacyMapping AS HP
					INNER JOIN PharmacyAvailability AS PA
					ON HP.HospitalPharmacyId = PA.HospitalPharmacyId
					INNER JOIN Slots AS S
					ON S.SlotId = PA.SlotId
							WHERE HP.HospitalId = @hospitalid 
							  AND HP.PharmacyId = @pharmacyid
							  AND PA.IsAvailable = 1
			

		
		
		COMMIT TRANSACTION GetPharmacyAvailability
	 
	 END