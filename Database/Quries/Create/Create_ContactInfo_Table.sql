USE MedicalManagement
Go

CREATE TABLE [dbo].[ContactInfo] (
    [ContactInfoId]         INT            IDENTITY (1, 1) NOT NULL,
	[UserId]				INT								NOT NULL,
    [Address]              NVARCHAR (255) NULL,   
    [City]                  NVARCHAR (255) NULL,
    [Country]               NVARCHAR (2)   NULL,
    [State]                 NVARCHAR (255) NULL,
    [Zip]                   NVARCHAR (50)  NULL,
    [Phone]                 NVARCHAR (50)  NULL,
    [Extension]             NVARCHAR (20)  NULL,
    [Fax]                   NVARCHAR (20)  NULL,    
	[ModifiedOn]			DATETIME2	   CONSTRAINT [DF_ContactInfo_ModifiedOn] DEFAULT (GETUTCDATE()) NOT NULL,
    CONSTRAINT [PK_ContactInfo] PRIMARY KEY CLUSTERED ([ContactInfoId] ASC)
);


