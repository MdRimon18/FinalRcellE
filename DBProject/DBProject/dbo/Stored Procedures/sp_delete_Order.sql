CREATE PROCEDURE [dbo].[sp_delete_Order]
    @order_id INT,
    @Success INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if the record exists
        IF EXISTS (SELECT 1 FROM [dbo].[Order] WHERE OrderId = @order_id)
        BEGIN
            -- If the record exists, delete it
            DELETE FROM [dbo].[Order] WHERE OrderId = @order_id;
			select @order_id=1;
            SET @Success = 1; -- Set success flag to 1
        END
        ELSE
        BEGIN
            -- Record not found, set success flag to 0
            SET @Success = 0;
        END
    END TRY
    BEGIN CATCH
         SET @Success = 0; -- Error occurred, set success flag to 0
    END CATCH
END;
