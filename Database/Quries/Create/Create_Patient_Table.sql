USE MedicalManagement
Go

CREATE TABLE [dbo].[Patient] (
[PatientId]								INT              IDENTITY (1, 1) NOT NULL,	
[UserId]								INT   NOT NULL,
[UserGUID]								UNIQUEIDENTIFIER  DEFAULT (newid()) NOT NULL,
[CreateDate]							DATETIME									NOT NULL,
[LastUpdateDate]						DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]								BIT              CONSTRAINT [DF_Patient_IsDeleted] DEFAULT ((0)) NOT NULL,
CONSTRAINT [PK_Patient]					PRIMARY KEY CLUSTERED ([PatientId] ASC))


GO

CREATE NONCLUSTERED INDEX [IX_Patient_PatientId]
    ON [dbo].[Patient]([PatientId] ASC);
