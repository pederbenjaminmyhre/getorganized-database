CREATE TABLE [dbo].[tblTreeNode_backup_20250118] (
    [id]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [name]         NVARCHAR (100) NOT NULL,
    [parentId]     BIGINT         NOT NULL,
    [hasChildren]  BIT            NOT NULL,
    [detailedText] NVARCHAR (MAX) NULL,
    [customSort]   BIGINT         NULL
);

