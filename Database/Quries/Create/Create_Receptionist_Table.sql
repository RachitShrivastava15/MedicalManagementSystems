USE MedicalManagement
Go

CREATE TABLE [dbo].[Receptionist] (
[ReceptionistId]			INT              IDENTITY (1, 1) NOT NULL,	
[ReceptionistGUID]			UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
[UserId]				INT											NOT NULL,
[CreateDate]			DATETIME									NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_Receptionist_IsDeleted] DEFAULT ((0)) NOT NULL)


GO

CREATE NONCLUSTERED INDEX [IX_Pharmacy_ReceptionistId]
    ON [dbo].[Receptionist]([ReceptionistId] ASC);

Go
ALTER TABLE [Receptionist]
ADD CONSTRAINT [PK_Receptionist] PRIMARY KEY CLUSTERED ([ReceptionistId] ASC)

Go
ALTER TABLE [dbo].[Receptionist]
ADD 
CONSTRAINT [FK_Receptionist] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])


