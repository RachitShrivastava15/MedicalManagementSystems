USE MedicalManagement
Go

CREATE TABLE [dbo].[DoctorContactDetails] (
	[DoctorContactId]				INT				IDENTITY(1,1)				NOT NULL,
	[DoctorId]				INT				NOT NULL,
	[DoctorGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_DoctorContactDetails] PRIMARY KEY CLUSTERED ([DoctorContactId] ASC)
)

ALTER TABLE [dbo].[DoctorContactDetails]
ADD 
CONSTRAINT [FK_DoctorContactDetails] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([DoctorId]),
CONSTRAINT [FK_DoctorContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])