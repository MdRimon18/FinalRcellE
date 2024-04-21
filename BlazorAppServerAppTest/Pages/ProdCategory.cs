namespace Pms.Pages
{
    public class ProdCategory
    {

        public class ProductCategory

        {
            public long ProdCtgId { get; set; }
            public Guid? ProdCtgKey { get; set; }
            public long? BranchId { get; set; }
            public string ProdCtgName { get; set; }
            public DateTime EntryDateTime { get; set; }
            public long EntryBy { get; set; }
            public DateTime? LastModifyDate { get; set; }
            public long? LastModifyBy { get; set; }
            public DateTime? DeletedDate { get; set; }
            public long? DeletedBy { get; set; }
            public string? Status { get; set; }
        }
    }
}
