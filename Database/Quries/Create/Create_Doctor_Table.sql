USE MedicalManagement
Go

CREATE TABLE [dbo].[Doctor] (
[DoctorId]				INT				IDENTITY(1,1)				NOT NULL,
[UserId]				INT											NOT NULL,
[DoctorGUID]			UNIQUEIDENTIFIER DEFAULT (newid())			NOT NULL,
[CreateDate]			DATETIME									NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate())		NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_Doctor_IsDeleted] DEFAULT ((0)) NOT NULL)


GO

CREATE NONCLUSTERED INDEX [IX_Doctor_DoctorId]
    ON [dbo].[Doctor]([DoctorId] ASC);

ALTER TABLE DOCTOR
ADD CONSTRAINT [PK_Doctor] PRIMARY KEY CLUSTERED ([DoctorId] ASC)

ALTER TABLE [dbo].[Doctor]
ADD 
CONSTRAINT [FK_Doctor] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
