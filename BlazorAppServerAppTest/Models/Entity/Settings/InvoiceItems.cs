namespace Pms.Models.Entity.Settings
{
	public class InvoiceItems
	{
		public long InvoiceItemId { get; set; }
		public long InvoiceId { get; set; }
		public long ProductId { get; set; }
		public int Quantity { get; set; }
		public decimal BuyingPrice { get; set; }
		public decimal SellingPrice { get; set; }
		public decimal TotalPrice { get; set; }
		public decimal VatPercentg { get; set; }
		public decimal VatAmount { get; set; }
		public decimal DiscountPercentg { get; set; }
		public decimal DiscountAmount { get; set; }
		public DateTime? ExpirationDate { get; set; }
		public long? PromoOrCuppnAppliedId { get; set; }
		public string ProductImage { get; set; }
		public string CategoryName { get; set; }
		public string SubCtgName { get; set; }
		public string Unit { get; set; }
		public DateTime? LastModifyDate { get; set; }
		public long? LastModifyBy { get; set; }
		public DateTime? DeletedDate { get; set; }
		public long? DeletedBy { get; set; }
		public string Status { get; set; }
	}
}
