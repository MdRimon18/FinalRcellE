using Dapper;
using Pms.Helper;
using System.Data;
using Pms.Data.DbContex; 
using Pms.Models.Entity.Settings;


namespace Pms.Data.Repository
{
    public class BillingPlanService
    {
        private readonly IDbConnection _db;


        public BillingPlanService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<BillingPlan>> Get(long? BillingPlanId, string? BillingPlanKey,string BillingPlanName, long? LanguageId,int? PageNumber, int? PageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@BillingPlanId", BillingPlanId);
                parameters.Add("@BillingPlanKey", BillingPlanKey);
                parameters.Add("@BillingPlanName", BillingPlanName);
                parameters.Add("@LanguageId", LanguageId);
                parameters.Add("@PageNumber", PageNumber);
                parameters.Add("@PageSize", PageSize);

                return await _db.QueryAsync<Models.Entity.Settings.BillingPlan>("BillingPlan_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<BillingPlan>();
            }
        }

        public async Task<BillingPlan> GetById(long UnitId)

        {
            var units = await (Get(UnitId, null, null, null, 1, 1));
            return units.FirstOrDefault();
        }

        public async Task<BillingPlan> GetByKey(string UnitKey)

        {
            var units = await (Get(null, UnitKey, null, null, 1, 1));
            return units.FirstOrDefault();
        }


        public async Task<long> SaveOrUpdate(BillingPlan billingPlan)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@BillingPlanId", billingPlan.BillingPlanId, dbType: DbType.Int64, direction: ParameterDirection.Output);
                parameters.Add("@BillingPlanKey", billingPlan.BillingPlanKey);
                parameters.Add("@LanguageId", billingPlan.LanguageId);
                parameters.Add("@BillingPlanName", billingPlan.BillingPlanName);
                parameters.Add("@EntryDateTime", billingPlan.EntryDateTime);
                parameters.Add("@EntryBy", billingPlan.EntryBy);
                parameters.Add("@LastModifyDate", billingPlan.LastModifyDate);
                parameters.Add("@LastModifyBy", billingPlan.LastModifyBy);
                parameters.Add("@DeletedDate", billingPlan.DeletedDate);
                parameters.Add("@DeletedBy", billingPlan.DeletedBy);
                parameters.Add("@Status", billingPlan.Status);

                await _db.ExecuteAsync("BillingPlan_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);



                return parameters.Get<long>("@BillingPlanId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }
 
        public async Task<bool> Delete(long UnitId)
        {
            var unit = await (Get(UnitId, null, null, null, 1, 1));
            var deleteObj = unit.FirstOrDefault();
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
