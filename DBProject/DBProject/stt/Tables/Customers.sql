CREATE TABLE [stt].[Customers] (
    [CustomerId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [CustomerKey]    UNIQUEIDENTIFIER NOT NULL,
    [BranchId]       BIGINT           NOT NULL,
    [CustomerName]   NVARCHAR (100)   NOT NULL,
    [MobileNo]       NVARCHAR (100)   NOT NULL,
    [Email]          NVARCHAR (100)   NULL,
    [CountryId]      BIGINT           NOT NULL,
    [StateName]      NVARCHAR (100)   NOT NULL,
    [CustAddrssOne]  NVARCHAR (MAX)   NOT NULL,
    [CustAddrssTwo]  NVARCHAR (MAX)   NULL,
    [Occupation]     NVARCHAR (100)   NULL,
    [OfficeName]     NVARCHAR (100)   NULL,
    [CustImgLink]    NVARCHAR (180)   NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId] ASC)
);

