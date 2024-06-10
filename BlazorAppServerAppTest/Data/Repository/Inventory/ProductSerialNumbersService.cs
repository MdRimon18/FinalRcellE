using Dapper;
using Pms.Data.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;
using System.Data;

namespace Pms.Data.Repository.Inventory
{
	public class ProductSerialNumbersService
	{
		private readonly IDbConnection _db;


		public ProductSerialNumbersService(DbConnection db)
		{
			_db = db.GetDbConnection();

		}
		public async Task<IEnumerable<ProductSerialNumbers>> Get(long? ProdSerialNmbrId, string? ProdSerialNmbrKey, long? ProductId, string? SerialNumber, long? TagSupplierId, string? Remarks, string? SerialStatus, int? PageNumber, int? PageSize)
		{
			try
			{
				var parameters = new DynamicParameters();

				parameters.Add("@ProdSerialNmbrId", ProdSerialNmbrId);
				parameters.Add("@ProdSerialNmbrKey", ProdSerialNmbrKey);
				parameters.Add("@ProductId", ProductId);
				parameters.Add("@SerialNumber", SerialNumber);
				parameters.Add("@TagSupplierId", TagSupplierId);
				parameters.Add("@Remarks", Remarks);
				parameters.Add("@SerialStatus", SerialStatus);

				parameters.Add("@PageNumber", PageNumber);
				parameters.Add("@PageSize", PageSize);

				return await _db.QueryAsync<ProductSerialNumbers>("ProductSerialNumbers_getSp", parameters, commandType: CommandType.StoredProcedure);

			}
			catch (Exception ex)
			{

				return Enumerable.Empty<ProductSerialNumbers>();
			}
		}

		public async Task<ProductSerialNumbers> GetById(long ProdSerialNmbrId)

		{
			var _productSerialNumbers = await (Get(ProdSerialNmbrId, null,null,null,null,null, null, 1, 1));
			return _productSerialNumbers.FirstOrDefault();
		}

		public async Task<ProductSerialNumbers> GetByKey(string ProdSerialNmbrKey)

		{
			var _productSerialNumbers = await (Get(null, ProdSerialNmbrKey, null, null, null,null, null, 1, 1));
			return _productSerialNumbers.FirstOrDefault();
		}


		public async Task<long> SaveOrUpdate(ProductSerialNumbers _productSerialNumbers)
		{
			try
			{
				var parameters = new DynamicParameters();

				parameters.Add("@ProdSerialNmbrId", _productSerialNumbers.ProdSerialNmbrId);
				parameters.Add("@ProdSerialNmbrKey", _productSerialNumbers.ProdSerialNmbrKey);
				parameters.Add("@ProductId", _productSerialNumbers.ProductId);
				parameters.Add("@SerialNumber", _productSerialNumbers.SerialNumber);
				parameters.Add("@TagSupplierId", _productSerialNumbers.TagSupplierId);
				parameters.Add("@Remarks", _productSerialNumbers.Remarks);
				parameters.Add("@SerialStatus", _productSerialNumbers.SerialStatus);

				parameters.Add("@EntryDateTime", _productSerialNumbers.EntryDateTime);
				parameters.Add("@EntryBy", _productSerialNumbers.EntryBy);
				parameters.Add("@LastModifyDate", _productSerialNumbers.LastModifyDate);
				parameters.Add("@LastModifyBy", _productSerialNumbers.LastModifyBy);
				parameters.Add("@DeletedDate", _productSerialNumbers.DeletedDate);
				parameters.Add("@DeletedBy", _productSerialNumbers.DeletedBy);
				parameters.Add("@Status", _productSerialNumbers.Status);
				parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
				await _db.ExecuteAsync("ProductSerialNumbers_InsertOrUpdate_SP", parameters, commandType: CommandType.StoredProcedure);

				return (long)parameters.Get<int>("@SuccessOrFailId");
			}
			catch (Exception ex)
			{
				// Handle the exception (e.g., log the error)
				Console.WriteLine($"An error occurred while adding order: {ex.Message}");
				return 0;
			}
		}

		public async Task<bool> Delete(long ProdSerialNmbrId)
		{
			var _productSerialNumbers = await (Get(ProdSerialNmbrId, null, null, null, null, null, null, 1, 1));
			var deleteObj = _productSerialNumbers.FirstOrDefault();
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
