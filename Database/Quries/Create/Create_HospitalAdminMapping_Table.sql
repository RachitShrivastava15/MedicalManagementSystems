USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalAdminMapping] (
	[HospitalAdminId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				 NOT NULL,
	[HospitalGUID]				UNIQUEIDENTIFIER NOT NULL,
	[UserId]					INT				 NOT NULL,
	[UserGUID]					UNIQUEIDENTIFIER NOT NULL,
	[LastUpdateDate]			DATETIME		 NOT NULL,
	CONSTRAINT [PK_HospitalAdminMapping] PRIMARY KEY CLUSTERED ([HospitalAdminId] ASC)
)

ALTER TABLE [dbo].[HospitalAdminMapping]
ADD 
CONSTRAINT [FK_HospitalAdminMapping] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalAdminMapping_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])