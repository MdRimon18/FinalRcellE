CREATE TABLE [invnt].[ProductSubCategories] (
    [ProdSubCtgId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [ProdSubCtgKey]  UNIQUEIDENTIFIER NULL,
    [BranchId]       BIGINT           NOT NULL,
    [ProdCtgId]      BIGINT           NOT NULL,
    [ProdSubCtgName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_ProductSubCategories] PRIMARY KEY CLUSTERED ([ProdSubCtgId] ASC)
);

