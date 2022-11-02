USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalReceptionistMapping] (
	[HospitalReceptionistId]				INT				IDENTITY(1,1)				NOT NULL,
	[ReceptionistId]					INT				NOT NULL,
	[ReceptionistGUID]				UNIQUEIDENTIFIER NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalReceptionistMapping] PRIMARY KEY CLUSTERED ([HospitalReceptionistId] ASC)
)

ALTER TABLE [dbo].[HospitalReceptionistMapping]
ADD 
CONSTRAINT [FK_HospitalReceptionistMapping_Receptionist] FOREIGN KEY ([ReceptionistId]) REFERENCES [dbo].[Receptionist] ([ReceptionistId]),
CONSTRAINT [FK_HospitalReceptionistMapping_Hospital] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId])
	