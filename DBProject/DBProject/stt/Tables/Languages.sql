CREATE TABLE [stt].[Languages] (
    [LanguageId]     INT              IDENTITY (1, 1) NOT NULL,
    [LanguageKey]    UNIQUEIDENTIFIER NULL,
    [LanguageName]   VARCHAR (50)     NOT NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED ([LanguageId] ASC)
);

