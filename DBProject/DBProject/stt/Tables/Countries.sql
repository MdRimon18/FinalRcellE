CREATE TABLE [stt].[Countries] (
    [CountryId]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [CountryKey]     UNIQUEIDENTIFIER NULL,
    [LanguageId]     INT              NOT NULL,
    [CountryName]    NVARCHAR (100)   NOT NULL,
    [CntryShortName] NVARCHAR (15)    NULL,
    [CountryCode]    NVARCHAR (6)     NOT NULL,
    [Capital]        VARCHAR (100)    NOT NULL,
    [CurrencyId]     INT              NOT NULL,
    [CurrentArea]    DECIMAL (10, 2)  NULL,
    [Population]     DECIMAL (10, 2)  NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED ([CountryId] ASC)
);



