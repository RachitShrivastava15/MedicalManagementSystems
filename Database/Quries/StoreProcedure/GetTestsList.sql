USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTestsList]

AS
BEGIN
	
		BEGIN TRANSACTION GetTestsList
		
		SELECT TestsId,TestsName FROM [Tests]
		
		
		COMMIT TRANSACTION GetTestsList
	 
	 END