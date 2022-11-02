USE MedicalManagement
Go

CREATE TABLE [dbo].[Appointment] (
[AppointmentId]					INT              IDENTITY (1, 1) NOT NULL,	
[DAvailablityId]								INT   NULL,
[TAvailablityId]								INT   NULL,
[PAvailablityId]								INT   NULL,
[UserId]										INT   NOT NULL,

CONSTRAINT [PK_Appointment]					PRIMARY KEY CLUSTERED ([AppointmentId] ASC))


GO

CREATE NONCLUSTERED INDEX [IX_Appointment_AppointmentId]
    ON [dbo].[Appointment]([AppointmentId] ASC);

ALTER TABLE [dbo].[Appointment]
ADD 
CONSTRAINT [FK_DAppointment] FOREIGN KEY ([DAvailablityId]) REFERENCES [dbo].[DoctorAvailability] ([DoctorAvailabilityId])

ALTER TABLE [dbo].[Appointment]
ADD 
CONSTRAINT [FK_TAppointment] FOREIGN KEY ([TAvailablityId]) REFERENCES [dbo].[TestAvailability] ([TestAvailabilityId])

ALTER TABLE [dbo].[Appointment]
ADD 
CONSTRAINT [FK_PAppointment] FOREIGN KEY ([PAvailablityId]) REFERENCES [dbo].[PharmacyAvailability] ([PharmacyAvailabilityId])

ALTER TABLE [dbo].[Appointment]
ADD 
CONSTRAINT [FK_Appointment_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])