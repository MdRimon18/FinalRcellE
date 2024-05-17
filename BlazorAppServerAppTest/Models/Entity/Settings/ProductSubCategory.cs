using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class ProductSubCategory
    {
        public long ProdSubCtgId { get; set; }
        public Guid? ProdSubCtgKey { get; set; }
        public long BranchId { get; set; }
        public long ProdCtgId { get; set; }
        [Required(ErrorMessage = "Product Sub Category Name is required")]
        [DisplayName("Product Sub Category Name")]
        public string ProdSubCtgName { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
        public int total_row { get; set; }
       public string? ProdCtgName { get; set; }
    }
}
