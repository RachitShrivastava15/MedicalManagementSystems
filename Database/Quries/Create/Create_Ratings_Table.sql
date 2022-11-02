USE MedicalManagement
Go

CREATE TABLE Ratings (
[RatingId]           INT              IDENTITY (1, 1) NOT NULL,
[Rating]			 DECIMAL(2,1)     NULL
CONSTRAINT chk_Ratings CHECK (Rating >= 0 AND Rating <= 5)
)

GO
CREATE NONCLUSTERED INDEX [IX_Ratings_RatingId]
    ON [dbo].[Ratings]([RatingId] ASC);

GO
ALTER TABLE Ratings
ADD CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED ([RatingId] ASC)