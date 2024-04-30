
using Dapper;
using Microsoft.CodeAnalysis.Operations;
using Microsoft.JSInterop;
using Pms.Data.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Inventory;
using Pms.Pages.Inventory;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class BusinessTypesService
    {
        private readonly IDbConnection _db;


        public BusinessTypesService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<BusinessType>> Get(long? BusinessTypeId, string? BusinessTypeKey, long? LanguageId, string? BusinessTypeName, int? pagenumber, int? pageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@BusinessTypeId", BusinessTypeId);
                parameters.Add("@BusinessTypeKey", BusinessTypeKey);
                parameters.Add("@LanguageId", LanguageId);
                parameters.Add("@BusinessTypeName", BusinessTypeName);
                parameters.Add("@page_number", pagenumber);
                parameters.Add("@page_size", pageSize);

                return await _db.QueryAsync<BusinessType>("BusinessTypes_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<BusinessType>();
            }
        }

        public async Task<BusinessType> GetById(long BusinessTypeId)

        {
            var businessTypes = await (Get(BusinessTypeId, null, null, null, 1, 1));
            return businessTypes.FirstOrDefault();
        }

        public async Task<BusinessType> GetByKey(string BusinessTypeKey)

        {
            var businessTypes = await (Get(null, BusinessTypeKey, null, null, 1, 1));
            return businessTypes.FirstOrDefault();
        }


        public async Task<long> Save(BusinessType businessType)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@businessTypeId", dbType: DbType.Int64, direction: ParameterDirection.Output);
                parameters.Add("@languageId", businessType.LanguageId);
                parameters.Add("@businessTypeKey", businessType.BusinessTypeKey);
                parameters.Add("@businessTypeName", businessType.BusinessTypeName);
                parameters.Add("@entryDateTime", businessType.EntryDateTime);
                parameters.Add("@entryBy", businessType.EntryBy);
                await _db.ExecuteAsync("BusinessTypes_Insert_SP", parameters, commandType: CommandType.StoredProcedure);



                return parameters.Get<long>("@businessTypeId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }


        public async Task<bool> Update(BusinessType businessType)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@businessTypeId", businessType.BusinessTypeId);
            parameters.Add("@languageId", businessType.LanguageId);
            parameters.Add("@businessTypeName", businessType.BusinessTypeName);
            parameters.Add("@lastModifyDate", businessType.LastModifyDate);
            parameters.Add("@lastModifyBy", businessType.LastModifyBy);
            parameters.Add("@deletedDate", businessType.DeletedDate);
            parameters.Add("@DeletedBy", businessType.DeletedBy);
            parameters.Add("@Status", businessType.Status);
            parameters.Add("@success", dbType: DbType.Int32, direction: ParameterDirection.Output);
            await _db.ExecuteAsync("BusinessTypes_Update_SP",
                  parameters, commandType: CommandType.StoredProcedure);

            int success = parameters.Get<int>("@success");
            return success > 0;
        }


        public async Task<bool> Delete(long BusinessTypeId)
        {
            var businessTypes = await (Get(BusinessTypeId, null, null, null, 1, 1));
            var deleteObj = businessTypes.FirstOrDefault();
            bool isDeleted = false;
            if (deleteObj != null)
            {
                deleteObj.DeletedDate = DateTimeHelper.CurrentDateTime();
                deleteObj.DeletedBy = UserInfo.UserId;
                deleteObj.Status = "Deleted";
                isDeleted = await Update(deleteObj);
            }

            return isDeleted;
        }
    }
}
