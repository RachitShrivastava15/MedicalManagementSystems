USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSpecialityList]

AS
BEGIN
	
		BEGIN TRANSACTION GetSpecialityList
		
		SELECT SpecialityId,SpecialityName FROM [Speciality]
		
		
		COMMIT TRANSACTION GetSpecialityList
	 
	 END