USE MedicalManagement
Go

CREATE TABLE [dbo].[DoctorAvailability] (
[DoctorAvailabilityId]					INT              IDENTITY (1, 1) NOT NULL,	
[HospitalDoctorId]								INT   NOT NULL,
[SlotId]								INT   NOT NULL,
[IsAvailable]								BIT              CONSTRAINT [DF_DoctorAvailability_IsAvailable] DEFAULT ((0)) NOT NULL,
CONSTRAINT [PK_DoctorAvailability]					PRIMARY KEY CLUSTERED ([DoctorAvailabilityId] ASC))


GO

CREATE NONCLUSTERED INDEX [IX_DoctorAvailability_DoctorAvailabilityId]
    ON [dbo].[DoctorAvailability]([DoctorAvailabilityId] ASC);

ALTER TABLE [dbo].[DoctorAvailability]
ADD 
CONSTRAINT [FK_HospitalDoctorAvailability] FOREIGN KEY ([HospitalDoctorId]) REFERENCES [dbo].[HospitalDoctorMapping] ([HospitalDoctorId])

ALTER TABLE [dbo].[DoctorAvailability]
ADD 
CONSTRAINT [FK_DoctorAvailability_Slot] FOREIGN KEY ([SlotId]) REFERENCES [dbo].[Slots] ([SlotId])