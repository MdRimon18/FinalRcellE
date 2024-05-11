CREATE TABLE [stt].[Menus] (
    [MenuId]         BIGINT           IDENTITY (1, 1) NOT NULL,
    [Menukey]        UNIQUEIDENTIFIER NOT NULL,
    [MenuName]       NVARCHAR (100)   NOT NULL,
    [MenuCode]       VARCHAR (20)     NULL,
    [ParentMenuId]   INT              NULL,
    [PageUrl]        NVARCHAR (100)   NULL,
    [Action]         NVARCHAR (100)   NULL,
    [ActiveIcon]     NVARCHAR (100)   NULL,
    [LightIcon]      NVARCHAR (100)   NULL,
    [DarkIcon]       NVARCHAR (100)   NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [pk_MenuId] PRIMARY KEY CLUSTERED ([MenuId] ASC)
);

