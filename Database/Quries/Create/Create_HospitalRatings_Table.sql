USE MedicalManagement
Go

CREATE TABLE [dbo].[HospitalRating] (
	[HospitalRatingId]				INT				IDENTITY(1,1)				NOT NULL,
	[HospitalId]				INT				NOT NULL,
	[HospitalGUID]			UNIQUEIDENTIFIER NOT NULL,
	[RatingId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_HospitalRating] PRIMARY KEY CLUSTERED ([HospitalRatingId] ASC)
)

ALTER TABLE [dbo].[HospitalRating]
ADD 
CONSTRAINT [FK_HospitalRating_Hospital] FOREIGN KEY ([HospitalId]) REFERENCES [dbo].[Hospital] ([HospitalId]),
CONSTRAINT [FK_HospitalRating_Ratings] FOREIGN KEY ([RatingId]) REFERENCES [dbo].[Ratings] ([RatingId])