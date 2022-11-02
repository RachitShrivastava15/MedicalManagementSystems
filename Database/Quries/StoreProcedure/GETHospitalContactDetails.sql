USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GETHospitalContactDetails]

	@hospitalname			NVARCHAR(256)
	


AS
BEGIN
	
		BEGIN TRANSACTION GETHospitalContactDetails
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM [Hospital] WHERE HospitalName = @hospitalname)
			
			SELECT CI.Address,
				   CI.City,
				   CI.Country,
				   CI.Extension,
				   CI.Fax,
				   CI.Phone,
				   CI.State,
				   CI.Zip
				    FROM HospitalContactDetails AS HCD
					INNER JOIN ContactInfo AS CI
					ON CI.ContactInfoId = HCD.ContactInfoId
					WHERE HCD.HospitalId = @hospitalid
			

		
		
		COMMIT TRANSACTION GETHospitalContactDetails
	 
	 END