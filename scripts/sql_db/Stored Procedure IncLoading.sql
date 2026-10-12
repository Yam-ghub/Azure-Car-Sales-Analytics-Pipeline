-- Create a stored procedure named UpdateWatermarkTable
CREATE PROCEDURE UpdateWatermarkTable

    -- Declare an input parameter to receive the new watermark value
    @lastload VARCHAR(200)

AS
BEGIN
    -- Prevent SQL Server from returning messages about affected rows
    SET NOCOUNT ON;

    -- Start error handling
    BEGIN TRY

        -- Start a database transaction
        BEGIN TRANSACTION;

        -- Update the last_load column with the supplied parameter
        UPDATE water_table
        SET last_load = @lastload;

        -- Save the transaction permanently
        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        -- Roll back the transaction if it is still active
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Raise the original error to the caller
        THROW;

    END CATCH;
END;