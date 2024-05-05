CREATE TABLE [stt].[PaymentTypes] (
    [PaymentTypeId]    BIGINT           IDENTITY (1, 1) NOT NULL,
    [PaymentTypeKey]   UNIQUEIDENTIFIER NULL,
    [LanguageId]       INT              NOT NULL,
    [PaymentTypesName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]    DATETIME         NOT NULL,
    [EntryBy]          BIGINT           NOT NULL,
    [LastModifyDate]   DATETIME         NULL,
    [LastModifyBy]     BIGINT           NULL,
    [DeletedDate]      DATETIME         NULL,
    [DeletedBy]        BIGINT           NULL,
    [Status]           VARCHAR (10)     NULL,
    CONSTRAINT [PK_PaymentTypes] PRIMARY KEY CLUSTERED ([PaymentTypeId] ASC)
);

