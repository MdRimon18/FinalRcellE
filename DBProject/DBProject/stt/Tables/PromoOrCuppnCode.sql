CREATE TABLE [stt].[PromoOrCuppnCode] (
    [PromoOrCuppnId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [PromoOrCuppnKey]  UNIQUEIDENTIFIER NULL,
    [PromoOrCuppnName] NVARCHAR (100)   NOT NULL,
    [Code]             VARCHAR (20)     NOT NULL,
    [Discount]         DECIMAL (5, 2)   NOT NULL,
    [ValidFrom]        DATETIME         NOT NULL,
    [ValidTo]          DATETIME         NOT NULL,
    [MaxUses]          INT              NULL,
    [RemainingUses]    INT              NULL,
    [Description]      NVARCHAR (MAX)   NULL,
    [EntryDateTime]    DATETIME         NULL,
    [EntryBy]          BIGINT           NULL,
    [LastModifyDate]   DATETIME         NULL,
    [LastModifyBy]     BIGINT           NULL,
    [DeletedDate]      DATETIME         NULL,
    [DeletedBy]        BIGINT           NULL,
    [Status]           VARCHAR (10)     NULL,
    CONSTRAINT [PK_PromoOrCuppnId] PRIMARY KEY CLUSTERED ([PromoOrCuppnId] ASC),
    UNIQUE NONCLUSTERED ([Code] ASC)
);

