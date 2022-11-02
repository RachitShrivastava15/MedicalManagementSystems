USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPharmacyList]

AS
BEGIN
	
		BEGIN TRANSACTION GetPharmacyList
		
		SELECT PharmacyId,PharmacyName FROM [Pharmacy]
		
		
		COMMIT TRANSACTION GetPharmacyList
	 
	 END