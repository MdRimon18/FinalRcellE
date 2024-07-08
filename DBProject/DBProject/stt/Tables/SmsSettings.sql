CREATE TABLE [stt].[SmsSettings] (
    [SmsSttngId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [SmsSttngKey]    UNIQUEIDENTIFIER NOT NULL,
    [BranchID]       BIGINT           NOT NULL,
    [SmsTypeId]      BIGINT           NULL,
    [Title]          NVARCHAR (150)   NOT NULL,
    [SenderName]     NVARCHAR (100)   NULL,
    [SmsCode]        NVARCHAR (100)   NULL,
    [ApiUrl]         NVARCHAR (150)   NOT NULL,
    [UserName]       NVARCHAR (100)   NULL,
    [Password]       NVARCHAR (50)    NULL,
    [PortNumber]     NVARCHAR (50)    NULL,
    [IsDefault]      BIT              NOT NULL,
    [Remarks]        NVARCHAR (MAX)   NULL,
    [EntryDateTime]  DATETIME         NOT NULL,
    [EntryBy]        BIGINT           NOT NULL,
    [LastModifyDate] DATETIME         NULL,
    [LastModifyBy]   BIGINT           NULL,
    [DeletedDate]    DATETIME         NULL,
    [DeletedBy]      BIGINT           NULL,
    [Status]         VARCHAR (10)     NULL,
    CONSTRAINT [PK_Sms_Settings] PRIMARY KEY CLUSTERED ([SmsSttngId] ASC)
);

