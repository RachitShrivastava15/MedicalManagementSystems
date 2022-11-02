USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetHosiptalListByCountry]
	
	@countrycode			NVARCHAR(2)

AS
BEGIN
	
		BEGIN TRANSACTION GetHosiptalListByCountry
		
		DECLARE @country int
			SET @country= (SELECT CountryId FROM Country
							WHERE CountryISO2 = @countrycode)


		SELECT H.HospitalId,H.HospitalName FROM [Hospital] AS H
			INNER JOIN HospitalCountryMapping AS HC
			ON H.HospitalId = HC.HospitalId
				WHERE 
				HC.CountryId = @country
				
		
		
		COMMIT TRANSACTION GetHosiptalListByCountry
	 
	 END