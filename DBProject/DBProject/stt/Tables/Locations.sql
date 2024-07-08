CREATE TABLE [stt].[Locations] (
    [LocationId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [LocationKey]    UNIQUEIDENTIFIER NULL,
    [LocationName]   NVARCHAR (300)   NOT NULL,
    [EntryDateTime]  DATETIME         NULL,
    [EntryBy]        BIGINT           NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_LocationId] PRIMARY KEY CLUSTERED ([LocationId] ASC)
);

