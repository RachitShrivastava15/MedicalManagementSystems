USE MedicalManagement
Go

CREATE TABLE [dbo].[TestsRating] (
	[TestsRatingId]				INT				IDENTITY(1,1)				NOT NULL,
	[TestsId]				INT				NOT NULL,
	[TestsGUID]			UNIQUEIDENTIFIER NOT NULL,
	[RatingId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_TestsRating] PRIMARY KEY CLUSTERED ([TestsRatingId] ASC)
)

ALTER TABLE [dbo].[TestsRating]
ADD 
CONSTRAINT [FK_TestsRating_Tests] FOREIGN KEY ([TestsId]) REFERENCES [dbo].[Tests] ([TestsId]),
CONSTRAINT [FK_TestsRating_Ratings] FOREIGN KEY ([RatingId]) REFERENCES [dbo].[Ratings] ([RatingId])