USE MedicalManagement
Go

CREATE TABLE [dbo].[MedicinePharmacyStock] (
	[MedicinePharmacyStockId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalPharmacyId]					INT				NOT NULL,
	[PharmacyMedicineId]					INT				NOT NULL,
	[Stock]									INT				NOT NULL,
	[LastUpdateDate]						DATETIME		NOT NULL,
	CONSTRAINT [PK_MedicinePharmacyStock] PRIMARY KEY CLUSTERED ([MedicinePharmacyStockId] ASC)
)

ALTER TABLE [dbo].[MedicinePharmacyStock]
ADD 
CONSTRAINT [FK_MedicinePharmacyStock] FOREIGN KEY ([HospitalPharmacyId]) REFERENCES [dbo].[HospitalPharmacyMapping] ([HospitalPharmacyId]),
CONSTRAINT [FK_MedicinePharmacyStock_Medicine] FOREIGN KEY ([PharmacyMedicineId]) REFERENCES [dbo].[PharmacyMedicineMapping] ([PharmacyMedicineId])