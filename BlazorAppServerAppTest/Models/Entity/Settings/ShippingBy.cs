namespace Pms.Models.Entity.Settings
{
    public class ShippingBy
    {
        public long ShippingById { get; set; }
        public Guid? ShippingByKey { get; set; }
        public int LanguageId { get; set; }
        public string ShippingByName { get; set; }
        public DateTime EntryDateTime { get; set; }
        public long EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
