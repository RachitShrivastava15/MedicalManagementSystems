USE MedicalManagement
Go

CREATE TABLE [dbo].[DoctorSpecialityMapping] (
	[DoctorSpecialityId]				INT				IDENTITY(1,1)				NOT NULL,
	[SpecialityId]						INT				NOT NULL,
	[SpecialityGUID]					UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
	[DoctorId]							INT				NOT NULL,
	[DoctorGUID]						UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]					DATETIME		NOT NULL,
	CONSTRAINT [PK_DoctorSpecialityMapping] PRIMARY KEY CLUSTERED ([DoctorSpecialityId] ASC)
)

ALTER TABLE [dbo].[DoctorSpecialityMapping]
ADD 
CONSTRAINT [FK_DoctorSpecialityMapping_Speciality] FOREIGN KEY ([SpecialityId]) REFERENCES [dbo].[Speciality] ([SpecialityId]),
CONSTRAINT [FK_DoctorSpecialityMapping_Doctor] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([DoctorId])

