CREATE TABLE [stt].[StatusSettings] (
    [StatusSettingId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [StatusSettingKey]  UNIQUEIDENTIFIER NULL,
    [BranchId]          INT              NOT NULL,
    [StatusSettingName] NVARCHAR (100)   NOT NULL,
    [PageName]          NVARCHAR (100)   NOT NULL,
    [Position]          INT              NULL,
    [EntryDateTime]     DATETIME         NOT NULL,
    [EntryBy]           BIGINT           NOT NULL,
    [LastModifyDate]    DATETIME         NULL,
    [LastModifyBy]      BIGINT           NULL,
    [DeletedDate]       DATETIME         NULL,
    [DeletedBy]         BIGINT           NULL,
    [Status]            VARCHAR (10)     NULL,
    CONSTRAINT [PK_StatusSettings] PRIMARY KEY CLUSTERED ([StatusSettingId] ASC)
);

