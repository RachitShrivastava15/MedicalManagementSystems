USE [MedicalManagement]
GO
/****** Object:  StoredProcedure [dbo].[GetUserSaltHash]    Script Date: 20-11-2021 14:21:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserSaltHash]

	@emailAddress				NVARCHAR (256),
	@passworduserhash				NVARCHAR (4000) OUTPUT,
	@passwordsalt				NVARCHAR (256) OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;    
	SET XACT_ABORT ON; 
	BEGIN TRY
	 SET @passworduserhash = null
	 SET @passwordsalt = null
		
		DECLARE @userid INT

		SET @userid= (SELECT U.UserId FROM [Users] U  WHERE Email = @emailAddress)
		
		Set @passworduserhash = (SELECT UP.PasswordHash FROM [UsersPassword] UP  WHERE UP.UserId = @userid)
		Set @passwordsalt = (SELECT UP.PasswordSalt FROM [UsersPassword] UP  WHERE UP.UserId = @userid)
		 END TRY
		 BEGIN CATCH
			IF (XACT_STATE()) = -1
		BEGIN
			 PRINT N'The transaction is in an uncommittable state.' + 'Rolling back transaction GetUserSaltHash.'
		END;
		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
			PRINT  N'The transaction is committable.' +	'Committing transaction GetUserSaltHash.'
		END;
	END CATCH
END