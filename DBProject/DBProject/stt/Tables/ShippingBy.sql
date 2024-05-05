CREATE TABLE [stt].[ShippingBy] (
    [ShippingById]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [ShippingByKey]  UNIQUEIDENTIFIER NULL,
    [LanguageId]     INT              NOT NULL,
    [ShippingByName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_ShippingBy] PRIMARY KEY CLUSTERED ([ShippingById] ASC)
);

