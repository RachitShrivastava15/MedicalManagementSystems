USE MedicalManagement
Go

CREATE TABLE [dbo].[DoctorRating] (
	[DoctorRatingId]				INT				IDENTITY(1,1)				NOT NULL,
	[DoctorId]						INT				NOT NULL,
	[DoctorGUID]					UNIQUEIDENTIFIER NOT NULL,
	[RatingId]						INT				NOT NULL,
	[LastUpdateDate]				DATETIME		NOT NULL,
	CONSTRAINT [PK_DoctorRating]	PRIMARY KEY CLUSTERED ([DoctorRatingId] ASC)
)

ALTER TABLE [dbo].[DoctorRating]
ADD 
CONSTRAINT [FK_DoctorRating_Doctor] FOREIGN KEY ([DoctorId]) REFERENCES [dbo].[Doctor] ([DoctorId]),
CONSTRAINT [FK_DoctorRating_Ratings] FOREIGN KEY ([RatingId]) REFERENCES [dbo].[Ratings] ([RatingId])