USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyListByHospital]

	@hospitalname			NVARCHAR(256)


AS
BEGIN
	
		BEGIN TRANSACTION GetPharmacyListByHospital
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)

			SELECT P.PharmacyName,P.PharmacyId FROM HospitalPharmacyMapping AS HP
				INNER JOIN Pharmacy AS P				
				ON P.PharmacyId = HP.Pharmacyid
							WHERE HP.HospitalId = @hospitalid 
			

		
		
		COMMIT TRANSACTION GetPharmacyListByHospital
	 
	 END