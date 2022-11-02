USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetHosiptalList]

AS
BEGIN
	
		BEGIN TRANSACTION GetHosiptalList
		
		SELECT HospitalId,HospitalName FROM [Hospital]
		
		
		COMMIT TRANSACTION GetHosiptalList
	 
	 END