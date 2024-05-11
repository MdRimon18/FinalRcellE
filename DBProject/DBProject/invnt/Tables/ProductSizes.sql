CREATE TABLE [invnt].[ProductSizes] (
    [ProductSizeId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [ProductSizeKey]  UNIQUEIDENTIFIER NULL,
    [LanguageId]      INT              NOT NULL,
    [ProductSizeName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]   DATETIME         NULL,
    [EntryBy]         BIGINT           NULL,
    [LastModifyDate]  DATETIME         NULL,
    [LastModifyBy]    BIGINT           NULL,
    [DeletedDate]     DATETIME         NULL,
    [DeletedBy]       BIGINT           NULL,
    [Status]          VARCHAR (10)     NULL,
    CONSTRAINT [PK_ProductSizeId] PRIMARY KEY CLUSTERED ([ProductSizeId] ASC)
);

