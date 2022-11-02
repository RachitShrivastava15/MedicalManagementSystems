USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetHospitalFullDocTestPha]

	@hospitalname			NVARCHAR(256)


AS
BEGIN
	
		BEGIN TRANSACTION GetHospitalFullDocTestPha	
		

			EXEC GetDoctorListByHospital @hospitalname
			EXEC GetTestListByHospital @hospitalname
			EXEC GetPharmacyListByHospital @hospitalname
		
		
		COMMIT TRANSACTION GetHospitalFullDocTestPha
	 
	 END