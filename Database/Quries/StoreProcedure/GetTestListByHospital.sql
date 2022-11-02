USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTestListByHospital]

	@hospitalname			NVARCHAR(256)


AS
BEGIN
	
		BEGIN TRANSACTION GetTestListByHospital
		
		DECLARE @hospitalid INT

			SET @hospitalid = (SELECT HospitalId FROM Hospital WHERE HospitalName = @hospitalname)

			SELECT T.TestsName, T.TestsId FROM HospitalTestsMapping AS HD
				INNER JOIN Tests AS T				
				ON T.TestsId = HD.TestsId
							WHERE HD.HospitalId = @hospitalid 
			

		
		
		COMMIT TRANSACTION GetTestListByHospital
	 
	 END