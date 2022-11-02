USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalTestsMapping] (
	[HospitalTestId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				 NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[TestsId]					INT				 NOT NULL,
	[TestsGUID]					UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		 NOT NULL,
	CONSTRAINT [PK_HospitalTestsMapping] PRIMARY KEY CLUSTERED ([HospitalTestId] ASC)
)

ALTER TABLE [dbo].[HospitalTestsMapping]
ADD 
CONSTRAINT [FK_HospitalTestsMapping] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalTestsMapping_ContactInfo] FOREIGN KEY ([TestsId]) REFERENCES [dbo].[Tests] ([TestsId])