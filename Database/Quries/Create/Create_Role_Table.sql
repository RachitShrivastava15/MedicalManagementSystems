USE MedicalManagement
Go

CREATE TABLE [dbo].[Role] (
[RoleId]           INT							IDENTITY (1, 1) NOT NULL,
[Name]             NVARCHAR (200)				NOT NULL,     
[RoleGUID]         UNIQUEIDENTIFIER CONSTRAINT [DF_Role_RoleGUID] DEFAULT (newid()) NOT NULL,
CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED ([RoleId] ASC))


