CREATE TABLE [stt].[Currencies] (
    [CurrencyId]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [CurrencyKey]       UNIQUEIDENTIFIER NULL,
    [BranchId]          BIGINT           NOT NULL,
    [LanguageId]        INT              NOT NULL,
    [CurrencyName]      NVARCHAR (100)   NOT NULL,
    [CurrencyCode]      VARCHAR (10)     NULL,
    [CurrencyShortName] NVARCHAR (15)    NOT NULL,
    [Symbol]            VARCHAR (12)     NOT NULL,
    [ExchangeRate]      DECIMAL (10, 4)  NOT NULL,
    [EntryDateTime]     DATETIME         NOT NULL,
    [EntryBy]           BIGINT           NOT NULL,
    [LastModifyDate]    DATETIME         NULL,
    [LastModifyBy]      BIGINT           NULL,
    [DeletedDate]       DATETIME         NULL,
    [DeletedBy]         BIGINT           NULL,
    [Status]            VARCHAR (10)     NULL,
    CONSTRAINT [PK_Currencies] PRIMARY KEY CLUSTERED ([CurrencyId] ASC)
);

