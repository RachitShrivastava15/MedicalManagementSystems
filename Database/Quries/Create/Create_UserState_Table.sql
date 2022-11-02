USE MedicalManagement
Go

CREATE TABLE [dbo].[UserState] (
[UserStateId]           INT							IDENTITY (1, 1) NOT NULL,
[State]		            NVARCHAR (200)				NOT NULL,     
[Description]		            NVARCHAR (200)				NOT NULL,     
CONSTRAINT [PK_UserState] PRIMARY KEY CLUSTERED ([UserStateId] ASC))


