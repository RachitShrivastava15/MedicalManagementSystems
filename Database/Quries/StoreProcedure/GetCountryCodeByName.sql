USE [MedicalManagement]
GO

CREATE PROCEDURE [dbo].[GetCountries]

AS
BEGIN
	
		BEGIN TRANSACTION GetCountries
		
		SELECT CountryISO2,CountryName FROM [COUNTRY]
		
		
		COMMIT TRANSACTION GetCountries
	 
	 END