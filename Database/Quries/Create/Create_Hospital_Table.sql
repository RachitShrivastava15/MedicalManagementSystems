USE MedicalManagement
Go

CREATE TABLE [dbo].[Hospital] (
[HospitalId]			INT										IDENTITY(1,1) NOT NULL,
[HospitalName]			Varchar(256)							NOT NULL,
[HospitalGUID]			UNIQUEIDENTIFIER DEFAULT (newid())		NOT NULL,
[CreateDate]			DATETIME								NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_Hospital_IsDeleted] DEFAULT ((0)) NOT NULL)


GO
CREATE NONCLUSTERED INDEX [IX_Hospital_HospitalName] ON [dbo].[Hospital]
	(
		[HospitalName] ASC
	)

GO
CREATE NONCLUSTERED INDEX [IX_Hospital_HospitalId]
    ON [dbo].[Hospital]([HospitalId] ASC);

GO

ALTER TABLE Hospital
ADD CONSTRAINT [PK_Hospital] PRIMARY KEY CLUSTERED ([HospitalId] ASC)