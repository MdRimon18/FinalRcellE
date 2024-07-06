CREATE TABLE [dbo].[Supplier] (
    [MobileNo]          NVARCHAR (20)  NOT NULL,
    [SupplierName]      NVARCHAR (100) NOT NULL,
    [CountryId]         BIGINT         NOT NULL,
    [StateName]         NVARCHAR (100) NOT NULL,
    [OrganaizationName] NVARCHAR (100) NOT NULL,
    [AddressLineOne]    NVARCHAR (MAX) NULL,
    [AddressLineTwo]    NVARCHAR (MAX) NULL,
    [BusinessTypeId]    BIGINT         NOT NULL,
    [Emaill]            NVARCHAR (100) NOT NULL,
    [OffDay]            NVARCHAR (100) NULL,
    [Image]             NVARCHAR (180) NOT NULL,
    [EntryBy]           BIGINT         NOT NULL,
    [LastModifyDate]    DATETIME       NULL,
    [LastModifyBy]      BIGINT         NULL,
    [DeletedDate]       DATETIME       NULL,
    [EntryDateTime]     DATETIME       NOT NULL,
    [DeletedBy]         BIGINT         NULL,
    [Status]            VARCHAR (10)   NULL
);

