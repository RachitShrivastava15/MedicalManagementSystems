USE MedicalManagement
Go

CREATE TABLE [dbo].[TestOwnerContactDetails] (
	[TestOwnerContactId]				INT				IDENTITY(1,1)				NOT NULL,
	[TestOwnerId]				INT				NOT NULL,
	[TestOwnerGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_TestOwnerContactDetails] PRIMARY KEY CLUSTERED ([TestOwnerContactId] ASC)
)

ALTER TABLE [dbo].[TestOwnerContactDetails]
ADD 
CONSTRAINT [FK_TestOwnerContactDetails] FOREIGN KEY ([TestOwnerId]) REFERENCES [dbo].[TestOwner] ([TestOwnerId]),
CONSTRAINT [FK_TestOwnerContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])