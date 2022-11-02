USE MedicalManagement
Go

CREATE TABLE [dbo].[Slots] (
[SlotId]				INT				IDENTITY(1,1)				NOT NULL,
[SlotTime]				NVARCHAR(10)								NOT NULL)



GO

CREATE NONCLUSTERED INDEX [IX_Slots_SlotId]
    ON [dbo].[Slots]([SlotId] ASC);

ALTER TABLE Slots
ADD CONSTRAINT [PK_Slot] PRIMARY KEY CLUSTERED ([SlotId] ASC)

