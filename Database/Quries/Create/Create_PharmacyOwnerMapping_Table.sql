USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyOwnerMapping] (
	[PharmacyOwnerMappingId]	INT				IDENTITY(1,1)				NOT NULL,
	[PharmacyId]				INT				NOT NULL,
	[PharmacyGUID]				UNIQUEIDENTIFIER NOT NULL,
	[PharmacyOwnerId]				INT				NOT NULL,
	[PharmacyOwnerGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_PharmacyOwnerMapping] PRIMARY KEY CLUSTERED ([PharmacyOwnerMappingId] ASC)
)

ALTER TABLE [dbo].[PharmacyOwnerMapping]
ADD 
CONSTRAINT [FK_PharmacyOwnerMapping_Pharmacy] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[Pharmacy] ([PharmacyId]),
CONSTRAINT [FK_PharmacyOwnerMapping_Hospital] FOREIGN KEY ([PharmacyOwnerId]) REFERENCES [dbo].[PharmacyOwner] ([PharmacyOwnerId])
	