CREATE PROCEDURE dbo.tblTreeNode_Select_id
    @Id BIGINT
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
        id = @Id;
END;
