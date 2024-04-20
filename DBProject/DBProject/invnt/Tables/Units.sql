CREATE TABLE [invnt].[Units] (
    [UnitId]         BIGINT           IDENTITY (1, 1) NOT NULL,
    [UnitKey]        UNIQUEIDENTIFIER NULL,
    [BranchId]       BIGINT           NOT NULL,
    [UnitName]       NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED ([UnitId] ASC)
);

