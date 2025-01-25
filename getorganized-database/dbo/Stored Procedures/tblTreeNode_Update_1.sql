CREATE PROCEDURE [dbo].[tblTreeNode_Update]
    @Id BIGINT,
    @Name NVARCHAR(100),
    @ParentId BIGINT,
    @HasChildren BIT,
    @DetailedText NVARCHAR(MAX),
    @CustomSort BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OldParentId BIGINT;
    DECLARE @ParentChanged BIT = 0;

    -- Look up the current record before the update
    SELECT @OldParentId = parentId
    FROM dbo.tblTreeNode
    WHERE id = @Id;

    -- Check if the ParentId is different
    IF @OldParentId <> @ParentId
    BEGIN
        SET @ParentChanged = 1;
    END

    -- Update the record identified by @Id
    UPDATE dbo.tblTreeNode
    SET
        name = @Name,
        parentId = @ParentId,
        hasChildren = @HasChildren,
        detailedText = @DetailedText,
        customSort = @CustomSort
    WHERE
        id = @Id;

    -- If the parent changed, adjust the hasChildren flag for the old and new parent records
    IF @ParentChanged = 1
    BEGIN
        -- Update the old parent's hasChildren flag if applicable
        IF @OldParentId IS NOT NULL
        BEGIN
            UPDATE dbo.tblTreeNode
            SET hasChildren = CASE 
                                WHEN EXISTS (
                                    SELECT 1 
                                    FROM dbo.tblTreeNode 
                                    WHERE parentId = @OldParentId
                                ) THEN 1
                                ELSE 0
                              END
            WHERE id = @OldParentId;
        END

        -- Update the new parent's hasChildren flag if applicable
        IF @ParentId IS NOT NULL
        BEGIN
            UPDATE dbo.tblTreeNode
            SET hasChildren = 1
            WHERE id = @ParentId;
        END
    END

    -- Return the updated record to the caller
	/*
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
		*/
END;
