USE MedicalManagement
Go

CREATE TABLE [dbo].[PharmacyRating] (
	[PharmacyRatingId]				INT				IDENTITY(1,1)				NOT NULL,
	[PharmacyId]				INT				NOT NULL,
	[PharmacyGUID]			UNIQUEIDENTIFIER NOT NULL,
	[RatingId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_PharmacyRating] PRIMARY KEY CLUSTERED ([PharmacyRatingId] ASC)
)

ALTER TABLE [dbo].[PharmacyRating]
ADD 
CONSTRAINT [FK_PharmacyRating_Pharmacy] FOREIGN KEY ([PharmacyId]) REFERENCES [dbo].[Pharmacy] ([PharmacyId]),
CONSTRAINT [FK_PharmacyRating_Ratings] FOREIGN KEY ([RatingId]) REFERENCES [dbo].[Ratings] ([RatingId])