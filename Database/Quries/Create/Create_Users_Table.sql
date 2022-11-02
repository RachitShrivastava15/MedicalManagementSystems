USE MedicalManagement
Go

CREATE TABLE [dbo].[Users] (
[UserId]								INT              IDENTITY (1, 1) NOT NULL,	
[Email]									NVARCHAR (256)   NOT NULL,
[FirstName]								NVARCHAR (256)   NOT NULL,
[LastName]								NVARCHAR (256)   NOT NULL,
[CreateDate]							DATETIME         NOT NULL,
[UserGUID]								UNIQUEIDENTIFIER  DEFAULT (newid()) NOT NULL,
[LastUpdateDate]						DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]								BIT              CONSTRAINT [DF_User_IsDeleted] DEFAULT ((0)) NOT NULL,
CONSTRAINT [PK_Users]					PRIMARY KEY CLUSTERED ([UserId] ASC),
CONSTRAINT [U_EMAIL]					UNIQUE NONCLUSTERED ([Email] ASC),
CONSTRAINT [CHK_User_Email]				CHECK (Email <> ''))


GO
CREATE NONCLUSTERED INDEX [IX_Users_FirstName_LastName] ON [dbo].[Users]
	(
		[FirstName] ASC,
		[LastName] ASC
	)

GO
CREATE NONCLUSTERED INDEX [IX_Users_UserId]
    ON [dbo].[Users]([UserId] ASC);