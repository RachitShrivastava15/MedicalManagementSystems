USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalPharmacyMapping] (
	[HospitalPharmacyId]				INT				IDENTITY(1,1)				NOT NULL,
	[PharmacyId]					INT				NOT NULL,
	[PharmacyGUID]				UNIQUEIDENTIFIER NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalPharmacyMapping] PRIMARY KEY CLUSTERED ([HospitalPharmacyId] ASC)
)

ALTER TABLE [dbo].[HospitalPharmacyMapping]
ADD 
CONSTRAINT [FK_HospitalPharmacyMapping_Pharmacy] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[Pharmacy] ([PharmacyId]),
CONSTRAINT [FK_HospitalPharmacyMapping_Hospital] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId])
	