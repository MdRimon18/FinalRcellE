CREATE TABLE [stt].[Users] (
    [UserId]          BIGINT           IDENTITY (1, 1) NOT NULL,
    [UserKey]         UNIQUEIDENTIFIER NULL,
    [UserName]        NVARCHAR (100)   NOT NULL,
    [UserPhoneNo]     NVARCHAR (100)   NOT NULL,
    [UserPassword]    NVARCHAR (20)    NOT NULL,
    [UserDesignation] NVARCHAR (100)   NULL,
    [UserImgLink]     NVARCHAR (180)   NULL,
    [EntryDateTime]   DATETIME         NULL,
    [EntryBy]         BIGINT           NULL,
    [LastModifyDate]  DATETIME         NULL,
    [LastModifyBy]    BIGINT           NULL,
    [DeletedDate]     DATETIME         NULL,
    [DeletedBy]       BIGINT           NULL,
    [Status]          VARCHAR (10)     NULL,
    CONSTRAINT [PK_UserId] PRIMARY KEY CLUSTERED ([UserId] ASC)
);

