﻿CREATE TABLE [invnt].[Invoice] (
    [InvoiceId]              BIGINT           IDENTITY (1, 1) NOT NULL,
    [InvoiceKey]             UNIQUEIDENTIFIER NULL,
    [BranchId]               BIGINT           NOT NULL,
    [InvoiceNumber]          NVARCHAR (50)    NOT NULL,
    [CustomerID]             INT              NOT NULL,
    [InvoiceDateTime]        DATETIME         NOT NULL,
    [InvoiceTypeId]          BIGINT           NOT NULL,
    [NotificationById]       BIGINT           NOT NULL,
    [SalesByName]            NVARCHAR (100)   NULL,
    [Notes]                  NVARCHAR (MAX)   NULL,
    [PaymentTypeId]          BIGINT           NOT NULL,
    [PaymentReference]       NVARCHAR (150)   NULL,
    [ShippingMethodId]       BIGINT           NULL,
    [CurrencyId]             BIGINT           NOT NULL,
    [OrderStatusId]          BIGINT           NULL,
    [TotalQnty]              INT              NOT NULL,
    [TotalAmount]            DECIMAL (10, 2)  NOT NULL,
    [TotalVat]               DECIMAL (10, 2)  NULL,
    [TotalDiscount]          DECIMAL (10, 2)  NULL,
    [TotalAddiDiscount]      DECIMAL (10, 2)  NULL,
    [TotalPayable]           DECIMAL (10, 2)  NOT NULL,
    [RecieveAmount]          DECIMAL (10, 2)  NOT NULL,
    [DueAmount]              DECIMAL (10, 2)  NULL,
    [DuePaymentDate]         DATETIME         NULL,
    [PromoOrCupponId]        BIGINT           NULL,
    [PolicyId]               BIGINT           NULL,
    [DeliveryDate]           DATETIME         NULL,
    [PriorityLevelId]        INT              NULL,
    [GiftOrder]              BIT              DEFAULT ((0)) NULL,
    [VoucherCode]            NVARCHAR (50)    NULL,
    [ShipmentTrackingNumber] NVARCHAR (100)   NULL,
    [ExchangeRate]           DECIMAL (18, 6)  DEFAULT ((1.00)) NULL,
    [ExpirationDate]         DATETIME         NULL,
    [EntryDateTime]          DATETIME         NULL,
    [EntryBy]                BIGINT           NULL,
    [LastModifyDate]         DATETIME         NULL,
    [LastModifyBy]           BIGINT           NULL,
    [DeletedDate]            DATETIME         NULL,
    [DeletedBy]              BIGINT           NULL,
    [Status]                 VARCHAR (10)     NULL,
    CONSTRAINT [PK_InvoiceId] PRIMARY KEY CLUSTERED ([InvoiceId] ASC),
    UNIQUE NONCLUSTERED ([InvoiceNumber] ASC)
);

