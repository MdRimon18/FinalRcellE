using Dapper;


using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Inventory;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class UnitService
    {
        private readonly IDbConnection _db;


        public UnitService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<Unit>> Get(long? UnitId, string? UnitKey, long? BranchId, string? UnitName, int? pagenumber, int? pageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@UnitId", UnitId);
                parameters.Add("@UnitKey", UnitKey);
                parameters.Add("@BranchId", BranchId);
                parameters.Add("@UnitName", UnitName);
                parameters.Add("@page_number", pagenumber);
                parameters.Add("@page_size", pageSize);
                
                return await _db.QueryAsync<Unit>("Unit_Get_SP", parameters, commandType: CommandType.StoredProcedure);
                
            }
            catch (Exception ex)
            {
    
                return Enumerable.Empty<Unit>();
            }
        }

        public async Task<Unit> GetById(long UnitId)

        {
            var units = await (Get(UnitId,null,null, null, 1,1));
            return units.FirstOrDefault();
        }

        public async Task<Unit> GetByKey(string UnitKey)

        {
            var units = await (Get(null, UnitKey, null, null, 1, 1));
            return units.FirstOrDefault();
        }


        public async Task<long> Save(Unit unit)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@UnitId", dbType: DbType.Int64, direction: ParameterDirection.Output);
                parameters.Add("@branchId", unit.BranchId);
                parameters.Add("@unitName", unit.UnitName);
                parameters.Add("@entryDateTime", unit.EntryDateTime);
                parameters.Add("@entryBy", unit.EntryBy);
                await _db.ExecuteAsync("Unit_Insert_SP", parameters, commandType: CommandType.StoredProcedure);



                return parameters.Get<long>("@UnitId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }


        public async Task<bool> Update(Unit unit)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@unitId", unit.UnitId);
            parameters.Add("@branchId", unit.BranchId);
            parameters.Add("@unitName", unit.UnitName);
            parameters.Add("@lastModifyDate", unit.LastModifyDate);
            parameters.Add("@lastModifyBy", unit.LastModifyBy);
            parameters.Add("@deletedDate", unit.DeletedDate);
            parameters.Add("@DeletedBy", unit.DeletedBy);
            parameters.Add("@Status", unit.Status);
            parameters.Add("@success", dbType: DbType.Int32, direction: ParameterDirection.Output);
            await _db.ExecuteAsync("Unit_Update_SP",
                  parameters, commandType: CommandType.StoredProcedure);

            int success = parameters.Get<int>("@success");
            return success > 0;
        }

        
        public async Task<bool> Delete(long UnitId)
        {
            var unit = await (Get(UnitId, null, null, null, 1, 1));
            var deleteObj = unit.FirstOrDefault();
            bool isDeleted = false;
            if (deleteObj != null)
            {
                deleteObj.DeletedBy = UserInfo.UserId;
                deleteObj.DeletedDate = DateTimeHelper.CurrentDateTime();
                deleteObj.Status = "Deleted";
                isDeleted = await Update(deleteObj);
            }

            return isDeleted;
        }
    }
}
