using Dapper;
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class ProductCategoryService
    {
        private readonly IDbConnection _db;


        public ProductCategoryService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<ProductCategories>> Get(long? ProdCtgId, string? ProdCtgKey, long? BranchId, string? ProdCtgName, int? pagenumber, int? pageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProdCtgId", ProdCtgId);
                parameters.Add("@ProdCtgKey", ProdCtgKey);
                parameters.Add("@BranchId", BranchId);
                parameters.Add("@ProdCtgName", ProdCtgName);
                parameters.Add("@page_number", pagenumber);
                parameters.Add("@page_size", pageSize);

                return await _db.QueryAsync<ProductCategories>("Product_Ctg_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<ProductCategories>();
            }
        }

        public async Task<ProductCategories> GetById(long ProdCtgId)

        {
            var productCategories = await (Get(ProdCtgId, null, null, null, 1, 1));
            return productCategories.FirstOrDefault();
        }

        public async Task<ProductCategories> GetByKey(string ProdCtgKey)

        {
            var productCategories = await (Get(null, ProdCtgKey, null, null, 1, 1));
            return productCategories.FirstOrDefault();
        }


        public async Task<long> Save(ProductCategories productCategories)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProdCtgId", dbType: DbType.Int64, direction: ParameterDirection.Output);
                parameters.Add("@branchId", productCategories.BranchId);
                parameters.Add("@ProdCtgName", productCategories.ProdCtgName);
                parameters.Add("@entryDateTime", productCategories.EntryDateTime);
                parameters.Add("@entryBy", productCategories.EntryBy);
                await _db.ExecuteAsync("Product_Ctg_Insert_SP", parameters, commandType: CommandType.StoredProcedure);



                return parameters.Get<long>("@ProdCtgId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }


        public async Task<bool> Update(ProductCategories productCategories)
        {
            var parameters = new DynamicParameters();
            parameters.Add("@ProdCtgId", productCategories.ProdCtgId);
            parameters.Add("@branchId", productCategories.BranchId);
            parameters.Add("@ProdCtgName", productCategories.ProdCtgName);
            parameters.Add("@lastModifyDate", productCategories.LastModifyDate);
            parameters.Add("@lastModifyBy", productCategories.LastModifyBy);
            parameters.Add("@deletedDate", productCategories.DeletedDate);
            parameters.Add("@DeletedBy", productCategories.DeletedBy);
            parameters.Add("@Status", productCategories.Status);
            parameters.Add("@success", dbType: DbType.Int32, direction: ParameterDirection.Output);
            await _db.ExecuteAsync("Product_Ctg_Update_SP",
                  parameters, commandType: CommandType.StoredProcedure);

            int success = parameters.Get<int>("@success");
            return success > 0;
        }


        public async Task<bool> Delete(long ProdCtgId)
        {
            var productCategories = await (Get(ProdCtgId, null, null, null, 1, 1));
            var deleteObj = productCategories.FirstOrDefault();
            bool isDeleted = false;
            if (deleteObj != null)
            {
                deleteObj.DeletedDate = DateTimeHelper.CurrentDateTime();
                deleteObj.Status = "Deleted";
                isDeleted = await Update(deleteObj);
            }

            return isDeleted;
        }
    }
}
