CREATE PROCEDURE [dbo].[tblTreeNode_Insert]
    @ParentId BIGINT = 0 -- Optional parameter, defaults to 0
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert the new record
    INSERT INTO dbo.tblTreeNode (name, parentId, hasChildren, detailedText, customSort)
    VALUES ('New Node', @ParentId, 0, NULL, NULL);

	UPDATE dbo.tblTreeNode SET name = 'New Node ' + CAST(SCOPE_IDENTITY() AS NVARCHAR(100))
	where id = SCOPE_IDENTITY();

	IF @ParentId <> 0
	BEGIN
		UPDATE dbo.tblTreeNode
		SET hasChildren = 1
		WHERE id = @ParentId
	END

    -- Return the newly inserted record
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
        id = SCOPE_IDENTITY();
END;


