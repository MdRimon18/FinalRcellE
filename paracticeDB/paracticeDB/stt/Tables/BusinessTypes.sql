CREATE TABLE [stt].[BusinessTypes] (
    [BusinessTypeId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [BusinessTypeKey]  UNIQUEIDENTIFIER NULL,
    [LanguageId]       INT              NOT NULL,
    [BusinessTypeName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]    DATETIME         NOT NULL,
    [EntryBy]          BIGINT           NOT NULL,
    [LastModifyDate]   DATETIME         NULL,
    [LastModifyBy]     BIGINT           NULL,
    [DeletedDate]      DATETIME         NULL,
    [DeletedBy]        BIGINT           NULL,
    [Status]           VARCHAR (10)     NULL,
    CONSTRAINT [PK_BusinessTypes] PRIMARY KEY CLUSTERED ([BusinessTypeId] ASC)
);

