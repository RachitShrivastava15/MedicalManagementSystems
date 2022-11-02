USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalCountryMapping] (
	[HospitalCountryId]			INT				IDENTITY(1,1)				NOT NULL,
	[CountryId]					INT				NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalCountryMapping] PRIMARY KEY CLUSTERED ([HospitalCountryId] ASC)
)

ALTER TABLE [dbo].[HospitalCountryMapping]
ADD 
CONSTRAINT [FK_HospitalCountryMapping_Country] FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId]),
CONSTRAINT [FK_HospitalCountryMapping_Hospital] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId])