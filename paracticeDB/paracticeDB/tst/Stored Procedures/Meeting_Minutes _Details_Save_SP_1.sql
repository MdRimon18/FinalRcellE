CREATE PROCEDURE [tst].[Meeting_Minutes _Details_Save_SP](
@meetng_Mnts_Dtls_ID INT,
@fk_Srvc_Id          INT,
@quantity            DECIMAL(10, 0),
@unit                NVARCHAR(50) = NULL)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      IF ( @meetng_Mnts_Dtls_ID = 0 )
        BEGIN
            INSERT INTO tst.meeting_minutes_details_tb
            VALUES      (  
                          @fk_Srvc_Id,
                          @quantity,
                          @unit )

            SET @meetng_Mnts_Dtls_ID = Scope_identity();

            SELECT @meetng_Mnts_Dtls_ID meetng_Mnts_Dtls_ID
        END
      ELSE
        BEGIN
            UPDATE a WITH(rowlock)
            SET   
                   a.fk_srvc_id = @fk_Srvc_Id,
                   a.quantity = @quantity,
                   a.unit = @unit
            FROM   tst.meeting_minutes_details_tb a WITH(rowlock)
            WHERE  a.meetng_mnts_dtls_id = @meetng_Mnts_Dtls_ID
        END
  END 