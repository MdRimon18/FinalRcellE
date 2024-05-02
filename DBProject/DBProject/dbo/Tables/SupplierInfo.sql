﻿CREATE TABLE [dbo].[SupplierInfo] (
    [SupplierId]           BIGINT           IDENTITY (1, 1) NOT NULL,
    [SupplierKey]          UNIQUEIDENTIFIER NULL,
    [BranchId]             BIGINT           NULL,
    [SupplierName]         NVARCHAR (100)   NOT NULL,
    [CountryId]            BIGINT           NOT NULL,
    [StateName]            NVARCHAR (100)   NOT NULL,
    [OrgnznName]           NVARCHAR (200)   NOT NULL,
    [SelectTypeId]         BIGINT           NOT NULL,
    [SupplierAddrsLineONe] NVARCHAR (200)   NOT NULL,
    [SupplierAddrsLineTwo] NCHAR (200)      NOT NULL,
    [DeliveryOffDay]       NVARCHAR (80)    NOT NULL,
    [Email]                NVARCHAR (100)   NOT NULL,
    [MobileNo]             NVARCHAR (100)   NOT NULL,
    [ImageLink]            NVARCHAR (180)   NOT NULL,
    [EntryDateTime]        DATETIME         NULL,
    [EntryBy]              BIGINT           NULL,
    [LastModifyDate]       DATETIME         NULL,
    [LastModifyBy]         BIGINT           NULL,
    [DeletedDate]          DATETIME         NULL,
    [DeletedBy]            BIGINT           NULL,
    [Status]               VARCHAR (10)     NULL,
    CONSTRAINT [PK_SupplierInfo] PRIMARY KEY CLUSTERED ([SupplierId] ASC)
);
