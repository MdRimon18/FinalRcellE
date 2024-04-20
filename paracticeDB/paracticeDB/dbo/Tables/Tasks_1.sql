CREATE TABLE [dbo].[Tasks] (
    [Id]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [Title]      NVARCHAR (200) NULL,
    [IsComplete] BIT            NULL,
    CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED ([Id] ASC)
);

