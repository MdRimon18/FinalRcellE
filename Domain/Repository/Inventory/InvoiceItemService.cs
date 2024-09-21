using Dapper;
using Pms.Domain.DbContex;
using Pms.Helper;
using Pms.Models.Entity.Settings;

using System.Data;
using System.Drawing;

namespace Pms.Data.Repository.Inventory
{
	
	
		public class InvoiceItemService
		{
			private readonly IDbConnection _db;


			public InvoiceItemService(DbConnection db)
			{
				_db = db.GetDbConnection();

			}
			public async Task<IEnumerable<InvoiceItems>> Get(long? InvoiceItemId,long? InvoiceId, long?ProductId, decimal? SellingPrice, decimal? BuyingPrice, string? CategoryName, string? SubCtgName, int? PageNumber, int? PageSize)
			{
				try
				{
					var parameters = new DynamicParameters();

				parameters.Add("@InvoiceItemId", InvoiceItemId);
				parameters.Add("@InvoiceId", InvoiceId);
				parameters.Add("@ProductId", ProductId);
				parameters.Add("@BuyingPrice", BuyingPrice);
				parameters.Add("@SellingPrice", SellingPrice);
				parameters.Add("@CategoryName", CategoryName);
				parameters.Add("@SubCtgName", SubCtgName);
				parameters.Add("@PageNumber", PageNumber);
				parameters.Add("@PageSize", PageSize);

					return await _db.QueryAsync<InvoiceItems>("Color_Get_SP", parameters, commandType: CommandType.StoredProcedure);

				}
				catch (Exception ex)
				{

					return Enumerable.Empty<InvoiceItems>();
				}
			}

			public async Task<InvoiceItems> GetById(long InvoiceItemId)

			{
				var _invoiceItems = await (Get(InvoiceItemId, null,null,null,null,null,null,1, 1));
				return _invoiceItems.FirstOrDefault();
			}

			


			public async Task<long> SaveOrUpdate(InvoiceItems _invoiceItems)
			{
				try
				{
					var parameters = new DynamicParameters();

				parameters.Add("@InvoiceItemId", _invoiceItems.InvoiceItemId);
				parameters.Add("@InvoiceId", _invoiceItems.InvoiceId);
				parameters.Add("@ProductId", _invoiceItems.ProductId);
				parameters.Add("@Quantity", _invoiceItems.Quantity);
				parameters.Add("@BuyingPrice", _invoiceItems.BuyingPrice);
				parameters.Add("@SellingPrice", _invoiceItems.SellingPrice);
				parameters.Add("@TotalPrice", _invoiceItems.TotalPrice);
				parameters.Add("@VatPercentg", _invoiceItems.VatPercentg);
				parameters.Add("@VatAmount", _invoiceItems.VatAmount);
				parameters.Add("@DiscountPercentg", _invoiceItems.DiscountPercentg);
				parameters.Add("@DiscountAmount", _invoiceItems.DiscountAmount);
				parameters.Add("@ExpirationDate", _invoiceItems.ExpirationDate);
				parameters.Add("@PromoOrCuppnAppliedId", _invoiceItems.PromoOrCuppnAppliedId);
				parameters.Add("@ProductImage", _invoiceItems.ProductImage);
				parameters.Add("@CategoryName", _invoiceItems.CategoryName);
				parameters.Add("@SubCtgName", _invoiceItems.SubCtgName);
				parameters.Add("@Unit", _invoiceItems.Unit);
				parameters.Add("@LastModifyDate", _invoiceItems.LastModifyDate);
					parameters.Add("@LastModifyBy", _invoiceItems.LastModifyBy);
					parameters.Add("@DeletedDate", _invoiceItems.DeletedDate);
					parameters.Add("@DeletedBy", _invoiceItems.DeletedBy);
					parameters.Add("@Status", _invoiceItems.Status);
					parameters.Add("@SuccessOrFailId", dbType: DbType.Int32, direction: ParameterDirection.Output);
					await _db.ExecuteAsync("InvoiceItemsInsertOrUpdateInvoice", parameters, commandType: CommandType.StoredProcedure);

					return (long)parameters.Get<int>("@SuccessOrFailId");
				}
				catch (Exception ex)
				{
					// Handle the exception (e.g., log the error)
					Console.WriteLine($"An error occurred while adding order: {ex.Message}");
					return 0;
				}
			}

			public async Task<bool> Delete(long InvoiceItemId)
			{
				var _invoiceItems = await (Get(InvoiceItemId, null, null, null, null, null, null, 1, 1));
				var deleteObj = _invoiceItems.FirstOrDefault();
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
