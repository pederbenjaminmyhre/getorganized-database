CREATE PROCEDURE [dbo].[tblTreeNode_Select_parentId]
    @ParentId BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id,
        name,
        parentId,
        hasChildren,
        detailedText,
        customSort
    FROM 
        dbo.tblTreeNode
    WHERE 
        parentId = @ParentId
	ORDER BY name;
END;

