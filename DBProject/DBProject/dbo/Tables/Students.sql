CREATE TABLE [dbo].[Students] (
    [StudentID] INT           NOT NULL,
    [FirstName] NVARCHAR (50) NOT NULL,
    [LastName]  NVARCHAR (50) NOT NULL,
    [BirthDate] DATE          NULL,
    PRIMARY KEY CLUSTERED ([StudentID] ASC)
);

