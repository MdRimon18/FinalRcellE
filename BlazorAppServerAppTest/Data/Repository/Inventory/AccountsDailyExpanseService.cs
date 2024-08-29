using Dapper;
using Pms.Data.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Pms.Data.Repository.Inventory
{
    public class AccountsDailyExpanseService
    {
        private readonly IDbConnection _db;


        public AccountsDailyExpanseService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<AccountsDailyExpanse>> Get(long? AccDailyExpanseId, string? AccDailyExpanseKey, int? AccHeadId, DateTime? Date,int? PageNumber, int? PageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@AccDailyExpanseId", AccDailyExpanseId);
                parameters.Add("@AccDailyExpanseKey", AccDailyExpanseKey);
                parameters.Add("@AccHeadId", AccHeadId);
                parameters.Add("@Date",Date);
                parameters.Add("@PageNumber", PageNumber);
                parameters.Add("@PageSize", PageSize);

                return await _db.QueryAsync<AccountsDailyExpanse>("AccountsDailyExpanse_get_sp", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<AccountsDailyExpanse>();
            }
        }

        public async Task<AccountsDailyExpanse> GetById(long AccDailyExpanseId)

        {
            var accountsDailyExpanse = await (Get(AccDailyExpanseId, null, null, null, 1, 1));
            return accountsDailyExpanse.FirstOrDefault();
        }

        public async Task<AccountsDailyExpanse> GetByKey(string AccDailyExpanseKey)

        {
            var accountsDailyExpanse = await (Get(null, AccDailyExpanseKey, null, null, 1, 1));
            return accountsDailyExpanse.FirstOrDefault();
        }


        public async Task<long> SaveOrUpdate(AccountsDailyExpanse accountsDailyExpanse)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@AccDailyExpanseId", accountsDailyExpanse.AccDailyExpanseId);
                parameters.Add("@AccDailyExpanseKey", accountsDailyExpanse.AccDailyExpanseKey);
                parameters.Add("@AccHeadId", accountsDailyExpanse.AccHeadId);
                parameters.Add("@Expense", accountsDailyExpanse.Expense);
                parameters.Add("@Date", accountsDailyExpanse.Date);
                parameters.Add("@Remarks", accountsDailyExpanse.Remarks);
                parameters.Add("@EntryDateTime", accountsDailyExpanse.EntryDateTime);
                parameters.Add("@EntryBy", accountsDailyExpanse.EntryBy);
                parameters.Add("@LastModifyDate", accountsDailyExpanse.LastModifyDate);
                parameters.Add("@LastModifyBy", accountsDailyExpanse.LastModifyBy);
                parameters.Add("@DeletedDate", accountsDailyExpanse.DeletedDate);
                parameters.Add("@DeletedBy", accountsDailyExpanse.DeletedBy);
                parameters.Add("@Status", accountsDailyExpanse.Status);
                parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
                await _db.ExecuteAsync("AccountsDailyExpanse_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);

                return (long)parameters.Get<int>("@SuccessOrFailId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }

        public async Task<bool> Delete(long AccDailyExpanseId)
        {
            var accountsDailyExpanse = await (Get(AccDailyExpanseId, null, null, null, 1, 1));
            var deleteObj = accountsDailyExpanse.FirstOrDefault();
            long DeletedSatatus = 0;
            if (deleteObj != null)
            {
                deleteObj.DeletedDate = DateTimeHelper.CurrentDateTime();
                deleteObj.Status = "Deleted";
                DeletedSatatus = await SaveOrUpdate(deleteObj);
            }

            return DeletedSatatus > 0;
        }
    }
}
