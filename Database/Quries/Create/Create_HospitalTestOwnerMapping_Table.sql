USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalTestOwnerMapping] (
	[HospitalTestId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				 NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[TestOwnerId]					INT				 NOT NULL,
	[TestOwnerGUID]					UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		 NOT NULL,
	CONSTRAINT [PK_HospitalTestOwnerMapping] PRIMARY KEY CLUSTERED ([HospitalTestId] ASC)
)

ALTER TABLE [dbo].[HospitalTestOwnerMapping]
ADD 
CONSTRAINT [FK_HospitalTestOwnerMapping] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalTestOwnerMapping_ContactInfo] FOREIGN KEY ([TestOwnerId]) REFERENCES [dbo].[TestOwner] ([TestOwnerId])