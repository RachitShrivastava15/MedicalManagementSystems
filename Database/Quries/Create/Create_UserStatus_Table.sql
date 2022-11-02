USE MedicalManagement
Go

CREATE TABLE [dbo].[UserStatus] (
[UserStatusId]				INT				IDENTITY(1,1)				NOT NULL,
[AppointmentId]				INT											NOT NULL,
[UserStateId]				INT											NOT NULL

)

GO

CREATE NONCLUSTERED INDEX [IX_UserStatus_UserStatusId]
    ON [dbo].[UserStatus]([UserStatusId] ASC);

ALTER TABLE UserStatus
ADD CONSTRAINT [PK_UserStatus] PRIMARY KEY CLUSTERED ([UserStatusId] ASC)

ALTER TABLE [dbo].[UserStatus]
ADD 
CONSTRAINT [FK_UserStatus_Appointment] FOREIGN KEY ([AppointmentId]) REFERENCES [dbo].[Appointment] ([AppointmentId])

ALTER TABLE [dbo].[UserState]
ADD 
CONSTRAINT [FK_UserStatus_UserState] FOREIGN KEY ([UserStateId]) REFERENCES [dbo].[UserState] ([UserStateId])
