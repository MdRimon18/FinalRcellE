CREATE TABLE [stt].[Colors] (
    [ColorId]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [ColorKey]       UNIQUEIDENTIFIER NULL,
    [LanguageId]     INT              NOT NULL,
    [ColorIdName]    NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_ColorId] PRIMARY KEY CLUSTERED ([ColorId] ASC)
);

