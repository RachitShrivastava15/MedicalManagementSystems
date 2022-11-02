USE MedicalManagement
Go

CREATE TABLE [dbo].[TestAvailability] (
[TestAvailabilityId]					INT              IDENTITY (1, 1) NOT NULL,	
[HospitalTestId]								INT   NOT NULL,
[SlotId]								INT   NOT NULL,
[IsAvailable]								BIT              CONSTRAINT [DF_Test_IsAvailable] DEFAULT ((0)) NOT NULL,
CONSTRAINT [PK_TestAvailability]					PRIMARY KEY CLUSTERED ([TestAvailabilityId] ASC))


GO

CREATE NONCLUSTERED INDEX [IX_TestAvailability_TestAvailabilityId]
    ON [dbo].[TestAvailability]([TestAvailabilityId] ASC);

ALTER TABLE [dbo].[TestAvailability]
ADD 
CONSTRAINT [FK_TestAvailability] FOREIGN KEY ([HospitalTestId]) REFERENCES [dbo].[HospitalTestsMapping] ([HospitalTestId])

ALTER TABLE [dbo].[TestAvailability]
ADD 
CONSTRAINT [FK_TestAvailability_Slot] FOREIGN KEY ([SlotId]) REFERENCES [dbo].[Slots] ([SlotId])