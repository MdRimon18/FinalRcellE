 CREATE PROCEDURE [tst].[Meeting_Minutes_Master_Save_SP](
@meetng_Mnts_Mstr_Id INT,
@is_Corporate_Mettng BIT = NULL,
@fk_Custmr_Id        INT,
@meetng_Agenda       NVARCHAR(max),
@meetng_Dt           DATETIME = NULL,
@time                TIME = NULL,
@metng_Plc           NVARCHAR(250),
@metng_Discssn       NVARCHAR(300),
@attnd_frm_Clnt_Side NVARCHAR(300),
@meetng_Dcssn        NVARCHAR(300),
@attnd_frm_Host_Side NVARCHAR(300),
@status              VARCHAR(50),
@entry_Date_Time     DATETIME)
AS
  BEGIN
      SET nocount ON
      SET TRANSACTION isolation level READ uncommitted

      IF ( @meetng_Mnts_Mstr_Id = 0 )
        BEGIN
            INSERT INTO tst.meeting_minutes_master_tbl
            VALUES      ( 
                          @is_Corporate_Mettng,
                          @fk_Custmr_Id,
                          @meetng_Agenda,
                          @meetng_Dt,
                          @time,
                          @metng_Plc,
                          @metng_Discssn,
                          @attnd_frm_Clnt_Side,
                          @meetng_Dcssn,
                          @attnd_frm_Host_Side,
                          @status,
                          @entry_Date_Time )

            SET @meetng_Mnts_Mstr_Id = Scope_identity();

            SELECT @meetng_Mnts_Mstr_Id meetng_Mnts_Mstr_Id
        END
      ELSE
        BEGIN
            UPDATE a WITH(rowlock)
            SET     
                   a.is_corporate_mettng = @is_Corporate_Mettng,
                   a.fk_custmr_id = @fk_Custmr_Id,
                   a.meetng_agenda = @meetng_Agenda,
                   a.meetng_dt = @meetng_Dt,
                   a.time = @time,
                   a.metng_plc = @metng_Plc,
                   a.metng_discssn = @metng_Discssn,
                   a.attnd_frm_clnt_side = @attnd_frm_Clnt_Side,
                   a.meetng_dcssn = @meetng_Dcssn,
                   a.attnd_frm_host_side = @attnd_frm_Host_Side,
                   a.status = @status,
                   a.entry_date_time = @entry_Date_Time
            FROM   tst.meeting_minutes_master_tbl a WITH(rowlock)
            WHERE  a.meetng_mnts_mstr_id = @meetng_Mnts_Mstr_Id
        END
  END 