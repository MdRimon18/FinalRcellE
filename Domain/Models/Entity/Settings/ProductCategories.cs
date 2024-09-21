using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class ProductCategories
    {
        public long ProdCtgId { get; set; }
        public Guid? ProdCtgKey { get; set; }
        public long? BranchId { get; set; }
        [Required(ErrorMessage = "Product Category Name is required")]
        [StringLength(100, ErrorMessage = "ProductCategories Name must not exceed 100 characters")]
        public string ProdCtgName { get; set; }
        public DateTime EntryDateTime { get; set; }
        public long EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
        public int total_row { get; set; }  
    }
}

