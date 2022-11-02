USE MedicalManagement
Go

CREATE TABLE [dbo].[UserRoles] (
	[UserRolesId]				INT				IDENTITY(1,1)				NOT NULL,
    [UserId] INT NOT NULL,
    [RoleId] INT NOT NULL,
	[LastUpdated]		 DATETIME NULL, 
	[LastUpdatedBy]		 INT	  NULL,
    CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED ([UserRolesId] ASC)    
);


ALTER TABLE [dbo].[UserRoles]
ADD CONSTRAINT [FK_UserRoles_Role] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Role] ([RoleId]),
    CONSTRAINT [FK_UserRoles_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])

GO
CREATE NONCLUSTERED INDEX [IX_RoleId_UserId]
    ON [dbo].[UserRoles]([RoleId] ASC, [UserId] ASC);

