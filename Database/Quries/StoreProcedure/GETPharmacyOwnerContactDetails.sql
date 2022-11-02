USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GETPharmacyOwnerContactDetails]

	@pharmacyname			NVARCHAR(256)
	


AS
BEGIN
	
		BEGIN TRANSACTION GETPharmacyOwnerContactDetails
		
		DECLARE @pharmacyid INT

			
			SET @pharmacyid = (SELECT PharmacyId FROM [Pharmacy] WHERE PharmacyName = @pharmacyname)
			
			SELECT CI.Address,
				   CI.City,
				   CI.Country,
				   CI.Extension,
				   CI.Fax,
				   CI.Phone,
				   CI.State,
				   CI.Zip
				    FROM PharmacyContactDetails AS PCD
					INNER JOIN ContactInfo AS CI
					ON CI.ContactInfoId = PCD.ContactInfoId
					WHERE PCD.PharmacyId = @pharmacyid
			

		
		
		COMMIT TRANSACTION GETPharmacyOwnerContactDetails
	 
	 END