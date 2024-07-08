CREATE TABLE [invnt].[ProductSerialNumbers] (
    [ProdSerialNmbrId]  BIGINT           IDENTITY (1, 1) NOT NULL,
    [ProdSerialNmbrKey] UNIQUEIDENTIFIER NULL,
    [ProductId]         BIGINT           NOT NULL,
    [SerialNumber]      NVARCHAR (150)   NULL,
    [TagSupplierId]     BIGINT           NULL,
    [Remarks]           NVARCHAR (MAX)   NULL,
    [SerialStatus]      NVARCHAR (15)    NOT NULL,
    [EntryDateTime]     DATETIME         NULL,
    [EntryBy]           BIGINT           NULL,
    [LastModifyDate]    DATETIME         NULL,
    [LastModifyBy]      BIGINT           NULL,
    [DeletedDate]       DATETIME         NULL,
    [DeletedBy]         BIGINT           NULL,
    [Status]            VARCHAR (10)     NULL,
    CONSTRAINT [PK_ProdSerialNmbrId] PRIMARY KEY CLUSTERED ([ProdSerialNmbrId] ASC)
);

