CREATE TABLE [stt].[InvoiceTypes] (
    [InvoiceTypeId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [InvoiceTypeKey]  UNIQUEIDENTIFIER NULL,
    [LanguageId]      INT              NOT NULL,
    [InvoiceTypeName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]   DATETIME         NOT NULL,
    [EntryBy]         BIGINT           NOT NULL,
    [LastModifyDate]  DATETIME         NULL,
    [LastModifyBy]    BIGINT           NULL,
    [DeletedDate]     DATETIME         NULL,
    [DeletedBy]       BIGINT           NULL,
    [Status]          VARCHAR (10)     NULL,
    CONSTRAINT [PK_InvoiceTypes] PRIMARY KEY CLUSTERED ([InvoiceTypeId] ASC)
);

