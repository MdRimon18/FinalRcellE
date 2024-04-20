CREATE TABLE [dbo].[Order] (
    [OrderId]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [OrderKey]         UNIQUEIDENTIFIER NULL,
    [ProductName]      NVARCHAR (100)   NOT NULL,
    [CategoryId]       BIGINT           NULL,
    [OrderDate]        DATETIME         NULL,
    [IsProductRecieve] BIT              NULL,
    [EntryDateTime]    DATETIME         NULL,
    [EntryBy]          BIGINT           NULL,
    [Status]           VARCHAR (10)     NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([OrderId] ASC)
);

