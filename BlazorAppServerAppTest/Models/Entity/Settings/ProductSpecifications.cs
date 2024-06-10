namespace Pms.Models.Entity.Settings
{
    public class ProductSpecifications
    {
        public long ProdSpcfctnId { get; set; }
        public Guid? ProdSpcfctnKey { get; set; }
        public long ProductId { get; set; }
        public string SpecificationName { get; set; }
        public string SpecificationDtls { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
