USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyAvailability] (
[PharmacyAvailabilityId]					INT              IDENTITY (1, 1) NOT NULL,	
[HospitalPharmacyId]								INT   NOT NULL,
[SlotId]								INT   NOT NULL,
[IsAvailable]								BIT              CONSTRAINT [DF_Pharmacy_IsAvailable] DEFAULT ((0)) NOT NULL,
CONSTRAINT [PK_PharmacyAvailability]					PRIMARY KEY CLUSTERED ([PharmacyAvailabilityId] ASC))


GO

CREATE NONCLUSTERED INDEX [IX_PharmacyAvailability_PharmacyAvailabilityId]
    ON [dbo].[PharmacyAvailability]([PharmacyAvailabilityId] ASC);

ALTER TABLE [dbo].[PharmacyAvailability]
ADD 
CONSTRAINT [FK_PharmacyAvailability] FOREIGN KEY ([HospitalPharmacyId]) REFERENCES [dbo].[HospitalPharmacyMapping] ([HospitalPharmacyId])

ALTER TABLE [dbo].[PharmacyAvailability]
ADD 
CONSTRAINT [FK_PharmacyAvailability_Slot] FOREIGN KEY ([SlotId]) REFERENCES [dbo].[Slots] ([SlotId])