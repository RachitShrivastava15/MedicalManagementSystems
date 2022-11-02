USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyOwner] (
[PharmacyOwnerId]			INT              IDENTITY (1, 1) NOT NULL,	
[PharmacyOwnerGUID]			UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
[UserId]				INT											NOT NULL,
[CreateDate]			DATETIME									NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_PharmacyOwner_IsDeleted] DEFAULT ((0)) NOT NULL)


GO

CREATE NONCLUSTERED INDEX [IX_Pharmacy_PharmacyOwnerId]
    ON [dbo].[PharmacyOwner]([PharmacyOwnerId] ASC);

Go
ALTER TABLE [PharmacyOwner]
ADD CONSTRAINT [PK_PharmacyOwner] PRIMARY KEY CLUSTERED ([PharmacyOwnerId] ASC)

Go
ALTER TABLE [dbo].[PharmacyOwner]
ADD 
CONSTRAINT [FK_PharmacyOwner] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])


