USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalDoctorMapping] (
	[HospitalDoctorId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[DoctorId]					INT				NOT NULL,
	[DoctorGUID]				UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalDoctorMapping] PRIMARY KEY CLUSTERED ([HospitalDoctorId] ASC)
)

ALTER TABLE [dbo].[HospitalDoctorMapping]
ADD 
CONSTRAINT [FK_HospitalDoctorMapping_Hospital] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalDoctorMapping_Doctor] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([DoctorId])