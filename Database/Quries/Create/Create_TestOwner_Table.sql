USE MedicalManagement
Go

CREATE TABLE [dbo].[TestOwner] (
[TestOwnerId]			INT              IDENTITY (1, 1) NOT NULL,	
[TestOwnerGUID]			UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
[UserId]				INT											NOT NULL,
[CreateDate]			DATETIME									NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]				BIT              CONSTRAINT [DF_TestOwner_IsDeleted] DEFAULT ((0)) NOT NULL)


GO

CREATE NONCLUSTERED INDEX [IX_Test_TestOwnerId]
    ON [dbo].[TestOwner]([TestOwnerId] ASC);

Go
ALTER TABLE [TestOwner]
ADD CONSTRAINT [PK_TestOwner] PRIMARY KEY CLUSTERED ([TestOwnerId] ASC)

Go
ALTER TABLE [dbo].[TestOwner]
ADD 
CONSTRAINT [FK_TestOwner] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])


