CREATE TABLE [Acc].[AccHeads] (
    [AccHeadId]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [AccHeadKey]     UNIQUEIDENTIFIER NULL,
    [AccHeadName]    NVARCHAR (100)   NOT NULL,
    [AccType]        NVARCHAR (50)    NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_AccHeads] PRIMARY KEY CLUSTERED ([AccHeadId] ASC)
);



