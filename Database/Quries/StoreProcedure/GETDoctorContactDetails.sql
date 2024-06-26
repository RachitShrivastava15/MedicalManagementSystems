USE [MedicalManagement]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GETDoctorContactDetails]

	--@email			NVARCHAR(256)
	@doctorid            INT


AS
BEGIN
	
		BEGIN TRANSACTION GETDoctorContactDetails
		
		--DECLARE @doctorid INT, @userId INT

		--	SET @userId = (SELECT USERID FROM [Users] WHERE Email = @email)
		--	SET @doctorid = (SELECT DoctorId FROM [Doctor] WHERE UserId = @userid)
			
			SELECT 
			       U.Email,
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
				    FROM DoctorContactDetails AS DCS
					INNER JOIN ContactInfo AS CI
					ON CI.ContactInfoId = DCS.ContactInfoId
					INNER JOIN Users AS U
					ON U.UserId = CI.USERID
					WHERE DCS.DoctorId = @doctorid
			

		
		
		COMMIT TRANSACTION GETDoctorContactDetails
	 
	 END