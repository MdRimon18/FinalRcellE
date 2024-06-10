namespace Pms.Models.Entity.Settings
{
    public class ProductSerialNumbers
    {
        public long ProdSerialNmbrId { get; set; }
        public Guid? ProdSerialNmbrKey { get; set; }
        public long ProductId { get; set; }
        public string SerialNumber { get; set; }
        public long? TagSupplierId { get; set; }
        public string Remarks { get; set; }
        public string SerialStatus { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
