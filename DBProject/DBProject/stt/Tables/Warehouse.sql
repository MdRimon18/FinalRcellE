CREATE TABLE [stt].[Warehouse] (
    [WarehouseId]    BIGINT           IDENTITY (1, 1) NOT NULL,
    [WarehouseKey]   UNIQUEIDENTIFIER NULL,
    [WarehouseName]  NVARCHAR (300)   NOT NULL,
    [LocationId]     BIGINT           NOT NULL,
    [ManagerName]    NVARCHAR (100)   NULL,
    [PhoneNumber]    NVARCHAR (20)    NULL,
    [Email]          NVARCHAR (100)   NULL,
    [Capacity]       INT              NULL,
    [OperatingHours] NVARCHAR (100)   NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_WarehouseId] PRIMARY KEY CLUSTERED ([WarehouseId] ASC)
);

