USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GETPatientContactDetails]

	@email			NVARCHAR(256)
	


AS
BEGIN
	
		BEGIN TRANSACTION GETPatientContactDetails
		
		DECLARE @userid INT

			--SET @userid = (SELECT UserId FROM [Users] WHERE Email = @email)
			
			SELECT U.Email,
				   U.FirstName,
				   U.LastName,
				   CI.Address,
				   CI.City,
				   CI.Country,
				   CI.Extension,
				   CI.Fax,
				   CI.Phone,
				   CI.State,
				   CI.Zip
				    FROM UsersContactDetails AS UCD
					INNER JOIN ContactInfo AS CI
					ON CI.ContactInfoId = UCD.ContactInfoId
					INNER JOIN [Users] AS U
					ON CI.USERID = U.UserId
					WHERE U.Email = @email
			

		
		
		COMMIT TRANSACTION GETPatientContactDetails
	 
	 END