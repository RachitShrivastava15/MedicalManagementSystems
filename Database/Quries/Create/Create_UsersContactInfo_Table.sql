USE MedicalManagement
Go

CREATE TABLE [dbo].[UsersContactDetails] (
	[UsersContactDetailsId]				INT				IDENTITY(1,1)				NOT NULL,
	[UserId]				INT				NOT NULL,
	[UserGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_UsersContactDetails] PRIMARY KEY CLUSTERED ([UsersContactDetailsId] ASC)
)

ALTER TABLE [dbo].[UsersContactDetails]
ADD 
CONSTRAINT [FK_UsersContactDetails] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
CONSTRAINT [FK_UsersContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])