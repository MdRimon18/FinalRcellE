CREATE TABLE [stt].[role_branch] (
    [role_branch_id] BIGINT IDENTITY (1, 1) NOT NULL,
    [role_id]        BIGINT NOT NULL,
    [branch_id]      BIGINT NOT NULL,
    PRIMARY KEY CLUSTERED ([role_branch_id] ASC)
);

