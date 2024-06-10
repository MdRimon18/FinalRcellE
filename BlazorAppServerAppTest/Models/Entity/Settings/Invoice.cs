namespace Pms.Models.Entity.Settings
{
    public class Invoice
    {
        public long InvoiceId { get; set; }
        public Guid? InvoiceKey { get; set; }
        public long BranchId { get; set; }
        public string InvoiceNumber { get; set; }
        public int CustomerID { get; set; }
        public DateTime InvoiceDateTime { get; set; }
        public long InvoiceTypeId { get; set; }
        public long NotificationById { get; set; }
        public string SalesByName { get; set; }
        public string Notes { get; set; }
        public long PaymentTypeId { get; set; }
        public string PaymentReference { get; set; }
        public long? ShippingMethodId { get; set; }
        public long CurrencyId { get; set; }
        public long? OrderStatusId { get; set; }
        public int TotalQnty { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal? TotalVat { get; set; }
        public decimal? TotalDiscount { get; set; }
        public decimal? TotalAddiDiscount { get; set; }
        public decimal TotalPayable { get; set; }
        public decimal RecieveAmount { get; set; }
        public decimal? DueAmount { get; set; }
        public DateTime? DuePaymentDate { get; set; }
        public long? PromoOrCupponId { get; set; }
        public long? PolicyId { get; set; }
        public DateTime? DeliveryDate { get; set; }
        public int? PriorityLevelId { get; set; }
        public bool? GiftOrder { get; set; }
        public string VoucherCode { get; set; }
        public string ShipmentTrackingNumber { get; set; }
        public decimal? ExchangeRate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
