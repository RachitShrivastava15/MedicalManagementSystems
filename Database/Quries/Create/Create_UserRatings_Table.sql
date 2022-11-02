USE MedicalManagement
Go

CREATE TABLE [dbo].[UserRating] (
	[UserRatingId]				INT				IDENTITY(1,1)				NOT NULL,
	[UserId]				INT				NOT NULL,
	[UserGUID]			UNIQUEIDENTIFIER NOT NULL,
	[RatingId]					INT				NOT NULL,
	[LastUpdateDate]			DATETIME		NOT NULL,
	CONSTRAINT [PK_UserRating] PRIMARY KEY CLUSTERED ([UserRatingId] ASC)
)

ALTER TABLE [dbo].[UserRating]
ADD 
CONSTRAINT [FK_UserRating_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
CONSTRAINT [FK_UserRating_Ratings] FOREIGN KEY ([RatingId]) REFERENCES [dbo].[Ratings] ([RatingId])