﻿CREATE TABLE [stt].[Companies] (
    [CompanyId]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [CompanyKey]         UNIQUEIDENTIFIER NOT NULL,
    [LanguageId]         INT              NOT NULL,
    [OwnerOrUserId]      BIGINT           NOT NULL,
    [CompanyName]        NVARCHAR (150)   NOT NULL,
    [BusinessTypeId]     BIGINT           NOT NULL,
    [CompMobileNo]       NVARCHAR (100)   NOT NULL,
    [CompanyEmail]       NVARCHAR (100)   NULL,
    [CountryId]          BIGINT           NOT NULL,
    [StateName]          NVARCHAR (100)   NOT NULL,
    [CompAddrss]         NVARCHAR (MAX)   NOT NULL,
    [CurrencyId]         BIGINT           NOT NULL,
    [BillingPlanId]      BIGINT           NOT NULL,
    [WorkingDays]        NVARCHAR (100)   NULL,
    [StartToEndTime]     NVARCHAR (100)   NULL,
    [CompanyLogoImgLink] NVARCHAR (180)   NULL,
    [IsHasBranch]        BIT              CONSTRAINT [DF__Companies__IsHas__00750D23] DEFAULT ((0)) NOT NULL,
    [EntryDateTime]      DATETIME         NOT NULL,
    [EntryBy]            BIGINT           NOT NULL,
    [LastModifyDate]     DATETIME         NULL,
    [LastModifyBy]       BIGINT           NULL,
    [DeletedDate]        DATETIME         NULL,
    [DeletedBy]          BIGINT           NULL,
    [Status]             VARCHAR (10)     NOT NULL,
    CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED ([CompanyId] ASC)
);
