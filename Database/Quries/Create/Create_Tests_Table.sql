USE MedicalManagement
Go

CREATE TABLE [dbo].[Tests] (
[TestsId]				INT              IDENTITY (1, 1) NOT NULL,	
[TestsName]				NVARCHAR (256)   NOT NULL,
[CreateDate]			DATETIME         NOT NULL,
[TestsGUID]				UNIQUEIDENTIFIER  DEFAULT (newid()) NOT NULL,
[LastUpdateDate]		DATETIME         DEFAULT (getutcdate()) NOT NULL,
CONSTRAINT [PK_Tests] PRIMARY KEY CLUSTERED ([TestsId] ASC))

GO
CREATE NONCLUSTERED INDEX [IX_Tests_TestsName] ON [dbo].[Tests]
	(
		[TestsName] ASC
	)