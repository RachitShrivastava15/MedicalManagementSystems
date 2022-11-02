USE MedicalManagement
Go

CREATE TABLE [dbo].[UsersPassword] (
	[UserPasswordId]				INT				IDENTITY(1,1)				NOT NULL,
	[UserId]						INT				NOT NULL,
	[PasswordHash]                  NVARCHAR (4000) NOT NULL,
    [PasswordSalt]                  NVARCHAR (256)  NOT NULL,
	CONSTRAINT [PK_UsersPassword] PRIMARY KEY CLUSTERED ([UserPasswordId] ASC)
)

ALTER TABLE [dbo].[UsersPassword]
ADD 
CONSTRAINT [FK_UsersPassword] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])