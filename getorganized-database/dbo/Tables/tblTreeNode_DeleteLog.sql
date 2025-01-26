CREATE TABLE [dbo].[tblTreeNode_DeleteLog] (
    [id]           BIGINT         NOT NULL,
    [name]         NVARCHAR (100) NOT NULL,
    [parentId]     BIGINT         NOT NULL,
    [hasChildren]  BIT            NOT NULL,
    [detailedText] NVARCHAR (MAX) NULL,
    [customSort]   BIGINT         NULL
);

