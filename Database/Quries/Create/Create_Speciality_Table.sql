USE MedicalManagement
Go

CREATE TABLE [dbo].[Speciality] (
[SpecialityId]			INT              IDENTITY (1, 1) NOT NULL,	
[SpecialityName]		NVARCHAR (256)   NOT NULL,
[SpecialityGUID]		UNIQUEIDENTIFIER  DEFAULT (newid()) NOT NULL,
CONSTRAINT [PK_Speciality] PRIMARY KEY CLUSTERED ([SpecialityId] ASC)
)