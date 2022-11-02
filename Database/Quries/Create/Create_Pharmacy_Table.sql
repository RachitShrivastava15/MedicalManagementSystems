USE MedicalManagement
Go

CREATE TABLE [dbo].[Pharmacy] (
[PharmacyId]			INT              IDENTITY (1, 1) NOT NULL,	
[PharmacyName]			NVARCHAR (256)   NOT NULL,
[PharmacyGUID]			UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
[CreateDate]			DATETIME         NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_Pharmacy_IsDeleted] DEFAULT ((0)) NOT NULL)


GO
CREATE NONCLUSTERED INDEX [IX_Pharmacy_PharmacyName] ON [dbo].[Pharmacy]
	(
		[PharmacyName] ASC
	)

GO
CREATE NONCLUSTERED INDEX [IX_Pharmacy_PharmacyId]
    ON [dbo].[Pharmacy]([PharmacyId] ASC);

Go
ALTER TABLE [Pharmacy]
ADD CONSTRAINT [PK_Pharmacy] PRIMARY KEY CLUSTERED ([PharmacyId] ASC)