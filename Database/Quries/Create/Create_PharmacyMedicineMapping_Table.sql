USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyMedicineMapping] (
	[PharmacyMedicineId]				INT				IDENTITY(1,1)				NOT NULL,
	[PharmacyId]				INT				 NOT NULL,
	[PharmacyGUID]				UNIQUEIDENTIFIER NOT NULL,
	[MedicineId]				INT				 NOT NULL,
	[MedicineGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		 NOT NULL,
	CONSTRAINT [PK_PharmacyMedicineMapping] PRIMARY KEY CLUSTERED ([PharmacyMedicineId] ASC)
)

ALTER TABLE [dbo].[PharmacyMedicineMapping]
ADD 
CONSTRAINT [FK_PharmacyMedicineMapping_Medicine] FOREIGN KEY ([MedicineId]) REFERENCES [dbo].[Medicines] ([MedicineId]),
CONSTRAINT [FK_PharmacyMedicineMapping_Pharmacy] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[Pharmacy] ([PharmacyId])