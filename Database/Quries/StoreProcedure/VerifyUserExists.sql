USE [MedicalManagement]
GO

CREATE PROCEDURE [dbo].[VerifyUserExists]

	@emailAddress				NVARCHAR (256),
	@isExists					BIT OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;    
	SET XACT_ABORT ON; 
	BEGIN TRY
	 SET @isExists = 0
		
		
		SELECT  U.Email,
		CASE WHEN U.Email = @emailAddress THEN 1			        
					 ELSE 0
					 END AS 'EmailMatch'
					 FROM [Users] U  WHERE Email = @emailAddress
			SELECT @isExists = CASE WHEN @@ROWCOUNT > 0 THEN 1 ELSE 0 END
		 RETURN @isExists
		 END TRY
		 BEGIN CATCH
			IF (XACT_STATE()) = -1
		BEGIN
			 PRINT N'The transaction is in an uncommittable state.' + 'Rolling back transaction VerifyUserExists.'
		END;
		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
			PRINT  N'The transaction is committable.' +	'Committing transaction VerifyUserExists.'
		END;
	END CATCH
END