using Dapper;
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class ProductSubCategoryService
    {
        private readonly IDbConnection _db;


        public ProductSubCategoryService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<ProductSubCategory>> Get(long? ProdSubCtgId, string? ProdSubCtgKey, long? BranchId, long? ProdCtgId, string ProdSubCtgName, int? PageNumber, int? PageSize)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProdSubCtgId", ProdSubCtgId);
                parameters.Add("@ProdSubCtgKey", ProdSubCtgKey);
                parameters.Add("@BranchId", BranchId);
                parameters.Add("@ProdCtgId", ProdCtgId);
                parameters.Add("@ProdSubCtgName", ProdSubCtgName);
               
                parameters.Add("@PageNumber", PageNumber);
                parameters.Add("@PageSize", PageSize);

                return await _db.QueryAsync<ProductSubCategory>("Prdct_Sub_Ctg_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<ProductSubCategory>();
            }
        }

        public async Task<ProductSubCategory> GetById(long ProdSubCtgId)

        {
            var productSubCategory = await (Get(ProdSubCtgId, null, null,null, null, 1, 1));
            return productSubCategory.FirstOrDefault();
        }

        public async Task<ProductSubCategory> GetByKey(string ProdSubCtgId)

        {
            var productSubCategory = await (Get(null, ProdSubCtgId, null,null, null, 1, 1));
            return productSubCategory.FirstOrDefault();
        }


        public async Task<long> SaveOrUpdate(ProductSubCategory productSubCategory)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProdSubCtgId", productSubCategory.ProdSubCtgId);
                parameters.Add("@ProdSubCtgKey", productSubCategory.ProdSubCtgKey);
                parameters.Add("@BranchId", productSubCategory.BranchId);
                parameters.Add("@ProdCtgId", productSubCategory.ProdCtgId);
                parameters.Add("@ProdSubCtgName", productSubCategory.ProdSubCtgName);
                parameters.Add("@EntryDateTime", productSubCategory.EntryDateTime);
                parameters.Add("@EntryBy", productSubCategory.EntryBy);
                parameters.Add("@LastModifyDate", productSubCategory.LastModifyDate);
                parameters.Add("@LastModifyBy", productSubCategory.LastModifyBy);
                parameters.Add("@DeletedDate", productSubCategory.DeletedDate);
                parameters.Add("@DeletedBy", productSubCategory.DeletedBy);
                parameters.Add("@Status", productSubCategory.Status);
                parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
                await _db.ExecuteAsync("Prdct_Sub_Ctg_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);

                return (long)parameters.Get<int>("@SuccessOrFailId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }

        public async Task<bool> Delete(long ProdSubCtgId)
        {
            var productSubCategory = await (Get(ProdSubCtgId, null,null, null, null, 1, 1));
            var deleteObj = productSubCategory.FirstOrDefault();
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

