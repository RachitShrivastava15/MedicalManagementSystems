USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalContactDetails] (
	[HospitalContactId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalContactDetails] PRIMARY KEY CLUSTERED ([HospitalContactId] ASC)
)

ALTER TABLE [dbo].[HospitalContactDetails]
ADD 
CONSTRAINT [FK_HospitalContactDetails] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])