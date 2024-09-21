using Dapper;
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Inventory;
using Pms.Models.Entity.Settings;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
    public class ProductMediaService
    {
        private readonly IDbConnection _db;


        public ProductMediaService(DbConnection db)
        {
            _db = db.GetDbConnection();

        }
        public async Task<IEnumerable<ProductImage>> Get(long? ProductMediaId, string? ProductMediaKey, long? ProductId, int? Position)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProductMediaId", ProductMediaId);
                parameters.Add("@ProductMediaKey", ProductMediaKey);
                parameters.Add("@ProductId", ProductId);
                parameters.Add("@Position", Position);
               

                return await _db.QueryAsync<ProductImage>("ProductMedia_Get_SP", parameters, commandType: CommandType.StoredProcedure);

            }
            catch (Exception ex)
            {

                return Enumerable.Empty<ProductImage>();
            }
        }

        public async Task<ProductImage> GetById(long ProductMediaId)

        {
            var productImage = await (Get(ProductMediaId, null, null, null));
            return productImage.FirstOrDefault();
        }

        public async Task<ProductImage> GetByKey(string ProductMediaKey)

        {
            var productImage = await (Get(null, ProductMediaKey, null, null));
            return productImage.FirstOrDefault();
        }


        public async Task<long> SaveOrUpdate(ProductImage productImage)
        {
            try
            {
                var parameters = new DynamicParameters();

                parameters.Add("@ProductMediaId", productImage.ProductMediaId);
                parameters.Add("@ProductMediaKey", productImage.ProductMediaKey);
                parameters.Add("@ProductId", productImage.ProductId);
                parameters.Add("@ImageUrl", productImage.ImageUrl);
                parameters.Add("@Position", productImage.Position);
                parameters.Add("@BodyPartName", productImage.BodyPartName);
                parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
                await _db.ExecuteAsync("ProductMedia_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);

                return (long)parameters.Get<int>("@SuccessOrFailId");
            }
            catch (Exception ex)
            {
                // Handle the exception (e.g., log the error)
                Console.WriteLine($"An error occurred while adding order: {ex.Message}");
                return 0;
            }
        }

        public async Task<bool> Delete(long ProductMediaId)
        {
            var productImage = await (Get(ProductMediaId, null, null, null));
            var deleteObj = productImage.FirstOrDefault();
            long DeletedSatatus = 0;
            if (deleteObj != null)
            {               
                DeletedSatatus = await SaveOrUpdate(deleteObj);
            }

            return DeletedSatatus > 0;
        }
    }
}
