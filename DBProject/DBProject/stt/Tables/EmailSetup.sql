CREATE TABLE [stt].[EmailSetup] (
    [EmailSetupId]   INT              IDENTITY (1, 1) NOT NULL,
    [EmailSetupkey]  UNIQUEIDENTIFIER NULL,
    [BranchId]       BIGINT           NOT NULL,
    [FromEmail]      NVARCHAR (150)   NULL,
    [FromName]       NVARCHAR (150)   NULL,
    [UserName]       NVARCHAR (150)   NULL,
    [Password]       NVARCHAR (500)   NULL,
    [BaseUrl]        NVARCHAR (250)   NULL,
    [ApiKey]         NVARCHAR (500)   NULL,
    [PortNumber]     BIGINT           NULL,
    [IsDefault]      BIT              NOT NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_EmailSetup] PRIMARY KEY CLUSTERED ([EmailSetupId] ASC)
);

