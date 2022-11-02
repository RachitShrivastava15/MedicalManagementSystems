USE MedicalManagement

CREATE TABLE [dbo].[Country] (
[CountryId]					INT					IDENTITY(1,1) NOT NULL,
[CountryName]				NVARCHAR (256)		NOT NULL,
[CountryISO2]				NVARCHAR(2)			NOT NULL,
CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED ([CountryId] ASC),
CONSTRAINT [UK_CountryISO2] UNIQUE NONCLUSTERED ([CountryISO2] ASC)
);