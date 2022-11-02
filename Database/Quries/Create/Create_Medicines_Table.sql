USE MedicalManagement
Go

CREATE TABLE [dbo].[Medicines] (
[MedicineId]				INT						IDENTITY (1, 1) NOT NULL,	
[MedicinesName]				NVARCHAR (256)			NOT NULL,
[CreateDate]				DATETIME				NOT NULL,
[MedicinesGUID]				UNIQUEIDENTIFIER		DEFAULT (newid()) NOT NULL,
[LastUpdateDate]			DATETIME				DEFAULT (getutcdate()) NOT NULL,
[IsDeleted]					BIT						CONSTRAINT [DF_Medicines_IsDeleted] DEFAULT ((0)) NOT NULL)

GO
CREATE NONCLUSTERED INDEX [IX_Medicines_MedicinesName] ON [dbo].[Medicines]
	(
		[MedicinesName] ASC
	)

GO
CREATE NONCLUSTERED INDEX [IX_Medicines_MedicinesId]
    ON [dbo].[Medicines]([MedicineId] ASC);
GO
ALTER TABLE Medicines
ADD CONSTRAINT [PK_Medicines] PRIMARY KEY CLUSTERED ([MedicineId] ASC)