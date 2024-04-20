CREATE TABLE [invnt].[ProductCategories] (
    [ProdCtgId]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [ProdCtgKey]     UNIQUEIDENTIFIER NULL,
    [BranchId]       BIGINT           NULL,
    [ProdCtgName]    NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NOT NULL,
    CONSTRAINT [PK_ProductCategories] PRIMARY KEY CLUSTERED ([ProdCtgId] ASC)
);

