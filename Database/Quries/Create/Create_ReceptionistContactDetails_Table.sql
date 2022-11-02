USE MedicalManagement
Go

CREATE TABLE [dbo].[ReceptionistContactDetails] (
	[ReceptionistContactId]				INT				IDENTITY(1,1)				NOT NULL,
	[ReceptionistId]				INT				NOT NULL,
	[ReceptionistGUID]			UNIQUEIDENTIFIER NOT NULL,
	[ContactInfoId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_ReceptionistContactDetails] PRIMARY KEY CLUSTERED ([ReceptionistContactId] ASC)
)

ALTER TABLE [dbo].[ReceptionistContactDetails]
ADD 
CONSTRAINT [FK_ReceptionistContactDetails] FOREIGN KEY ([ReceptionistId]) REFERENCES [dbo].[Receptionist] ([ReceptionistId]),
CONSTRAINT [FK_ReceptionistContactDetails_ContactInfo] FOREIGN KEY ([ContactInfoId]) REFERENCES [dbo].[ContactInfo] ([ContactInfoId])