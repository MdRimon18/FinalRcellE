CREATE TABLE [stt].[BillingPlans] (
    [BillingPlanId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [BillingPlanKey]  UNIQUEIDENTIFIER NULL,
    [LanguageId]      INT              NOT NULL,
    [BillingPlanName] NVARCHAR (100)   NOT NULL,
    [EntryDateTime]   DATETIME         NULL,
    [EntryBy]         BIGINT           NULL,
    [LastModifyDate]  DATETIME         NULL,
    [LastModifyBy]    BIGINT           NULL,
    [DeletedDate]     DATETIME         NULL,
    [DeletedBy]       BIGINT           NULL,
    [Status]          VARCHAR (10)     NULL,
    CONSTRAINT [PK_BillingPlanId] PRIMARY KEY CLUSTERED ([BillingPlanId] ASC)
);

