CREATE TABLE [dbo].[tblTreeNode] (
    [id]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [name]         NVARCHAR (100) NOT NULL,
    [parentId]     BIGINT         DEFAULT ((0)) NOT NULL,
    [hasChildren]  BIT            NOT NULL,
    [detailedText] NVARCHAR (MAX) NULL,
    [customSort]   BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

