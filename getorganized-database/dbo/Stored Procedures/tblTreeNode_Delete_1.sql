CREATE PROCEDURE [dbo].[tblTreeNode_Delete]
    @Id BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Retrieve the parentId from the record to be deleted
    DECLARE @ParentId BIGINT;
    SELECT @ParentId = parentId
    FROM dbo.tblTreeNode
    WHERE id = @Id;

	--DECLARE @Id BIGINT = 63

    -- Declare a table variable to store all descendants
    DECLARE @Descendants TABLE (id BIGINT);

    -- Use a recursive approach to populate the table variable
    WITH CTE_Descendants AS (
        SELECT id
        FROM dbo.tblTreeNode
        WHERE id = @Id
        UNION ALL
        SELECT t.id
        FROM dbo.tblTreeNode t
        INNER JOIN CTE_Descendants cte ON t.parentId = cte.id
    )
	INSERT INTO @Descendants (Id)
	SELECT Id
	FROM CTE_Descendants

	--SELECT * FROM @Descendants;

    -- Archive records before deleting them.
    INSERT INTO dbo.tblTreeNode_DeleteLog ([id], [name], [parentId], [hasChildren], [detailedText], [customSort])
    SELECT [id], [name], [parentId], [hasChildren], [detailedText], [customSort]
    FROM dbo.tblTreeNode
    WHERE id IN (SELECT id FROM @Descendants);

    -- Delete all descendant records including the provided id
    DELETE FROM dbo.tblTreeNode
    WHERE id IN (SELECT id FROM @Descendants);

    -- Update the parent record's hasChildren field if applicable
    IF @ParentId IS NOT NULL
    BEGIN
        UPDATE dbo.tblTreeNode
        SET hasChildren = CASE 
                            WHEN EXISTS (
                                SELECT 1 
                                FROM dbo.tblTreeNode 
                                WHERE parentId = @ParentId
                            ) THEN 1
                            ELSE 0
                          END
        WHERE id = @ParentId;
    END;

END;
