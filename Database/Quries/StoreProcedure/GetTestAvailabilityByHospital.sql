USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTestAvailabilityByHospital]

	@hospitalname			NVARCHAR(256),
	@testid				INT


AS
BEGIN
	
		BEGIN TRANSACTION GetTestAvailabilityByHospital
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)
			
			SELECT S.SlotTime, TA.IsAvailable, TA.TestAvailabilityId FROM HospitalTestsMapping AS HT
					INNER JOIN TestAvailability AS TA
					ON HT.HospitalTestId = TA.HospitalTestId
					INNER JOIN Slots AS S
					ON S.SlotId = TA.SlotId
							WHERE HT.HospitalId = @hospitalid 
							  AND HT.TestsId = @testid
							  AND TA.IsAvailable = 1
			

		
		
		COMMIT TRANSACTION GetTestAvailabilityByHospital
	 
	 END