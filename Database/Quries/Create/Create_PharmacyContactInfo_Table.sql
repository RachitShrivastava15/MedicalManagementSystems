USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyContactDetails] (
	[PharmacyContactId]				INT				IDENTITY(1,1)				NOT NULL,
	[PharmacyId]				INT				NOT NULL,
	[PharmacyGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_PharmacyContactDetails] PRIMARY KEY CLUSTERED ([PharmacyContactId] ASC)
)

ALTER TABLE [dbo].[PharmacyContactDetails]
ADD 
CONSTRAINT [FK_PharmacyContactDetails] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[Pharmacy] ([PharmacyId]),
CONSTRAINT [FK_PharmacyContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])