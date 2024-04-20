CREATE TABLE [dbo].[MainDbConfig] (
    [DbConfigId]               INT           IDENTITY (1, 1) NOT NULL,
    [CompanyId]                BIGINT        NULL,
    [BranchId]                 BIGINT        NULL,
    [ServerName]               NVARCHAR (50) NOT NULL,
    [DatabaseName]             NVARCHAR (50) NOT NULL,
    [Username]                 NVARCHAR (50) NULL,
    [Password]                 NVARCHAR (50) NULL,
    [TrustedConnection]        BIT           NOT NULL,
    [MultipleActiveResultSets] BIT           NOT NULL,
    [Encrypt]                  BIT           NOT NULL,
    [TrustServerCertificate]   BIT           NOT NULL,
    CONSTRAINT [PK_MainDbConfig] PRIMARY KEY CLUSTERED ([DbConfigId] ASC)
);

