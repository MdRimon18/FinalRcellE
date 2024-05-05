CREATE TABLE [stt].[Role] (
    [RoleId]         BIGINT           IDENTITY (1, 1) NOT NULL,
    [Rolekey]        UNIQUEIDENTIFIER NOT NULL,
    [RoleName]       NVARCHAR (100)   NOT NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [pk_RoleId] PRIMARY KEY CLUSTERED ([RoleId] ASC)
);

