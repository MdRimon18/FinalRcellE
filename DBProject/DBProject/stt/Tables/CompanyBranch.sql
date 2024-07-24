CREATE TABLE [stt].[CompanyBranch] (
    [BranchId]         BIGINT           IDENTITY (1, 1) NOT NULL,
    [BranchKey]        UNIQUEIDENTIFIER NOT NULL,
    [CompanyId]        BIGINT           NOT NULL,
    [BranchName]       NVARCHAR (100)   NOT NULL,
    [MobileNo]         NVARCHAR (100)   NOT NULL,
    [Email]            NVARCHAR (100)   NULL,
    [StateName]        NVARCHAR (100)   NOT NULL,
    [Address]          NVARCHAR (MAX)   NOT NULL,
    [BrnchManagerName] NVARCHAR (100)   NULL,
    [ManagerMobile]    NVARCHAR (100)   NULL,
    [BranchImgLink]    NVARCHAR (180)   NULL,
    [EntryDateTime]    DATETIME         NOT NULL,
    [EntryBy]          BIGINT           NOT NULL,
    [LastModifyDate]   DATETIME         NULL,
    [LastModifyBy]     BIGINT           NULL,
    [DeletedDate]      DATETIME         NULL,
    [DeletedBy]        BIGINT           NULL,
    [Status]           VARCHAR (10)     NOT NULL,
    CONSTRAINT [PK_CompanyBranch] PRIMARY KEY CLUSTERED ([BranchId] ASC)
);

