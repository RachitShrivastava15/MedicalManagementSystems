USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetHosiptalListByName]

	@hospitalname			NVARCHAR(256),
	@countrycode			NVARCHAR(2)

AS
BEGIN
	
		BEGIN TRANSACTION GetHosiptalListByName
		
		DECLARE @country int
			SET @country= (SELECT CountryId FROM Country
							WHERE CountryISO2 = @countrycode)


		SELECT H.HospitalId,H.HospitalName FROM [Hospital] AS H
			INNER JOIN HospitalCountryMapping AS HC
			ON H.HospitalId = HC.HospitalId
				WHERE 
				HC.CountryId = @country
				AND H.HospitalName like '%' + @hospitalname + '%'
		
		
		COMMIT TRANSACTION GetHosiptalListByName
	 
	 END