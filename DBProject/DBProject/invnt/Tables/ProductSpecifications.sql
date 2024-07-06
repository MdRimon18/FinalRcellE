CREATE TABLE [invnt].[ProductSpecifications] (
    [ProdSpcfctnId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [ProdSpcfctnKey]    UNIQUEIDENTIFIER NULL,
    [ProductId]         BIGINT           NOT NULL,
    [SpecificationName] NVARCHAR (150)   NULL,
    [SpecificationDtls] NVARCHAR (MAX)   NULL,
    [EntryDateTime]     DATETIME         NULL,
    [EntryBy]           BIGINT           NULL,
    [LastModifyDate]    DATETIME         NULL,
    [LastModifyBy]      BIGINT           NULL,
    [DeletedDate]       DATETIME         NULL,
    [DeletedBy]         BIGINT           NULL,
    [Status]            VARCHAR (10)     NULL,
    CONSTRAINT [PK_ProdSpcfctnId] PRIMARY KEY CLUSTERED ([ProdSpcfctnId] ASC)
);

