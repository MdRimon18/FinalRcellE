using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Inventory
{
    public class Unit
    {
        public long UnitId { get; set; }
        public Guid? UnitKey { get; set; }
        public long? BranchId { get; set; }
        [Required(ErrorMessage = "Unit Name is required")]
        [StringLength(100, ErrorMessage = "Unit Name must not exceed 100 characters")]
        public string UnitName { get; set; }
        public DateTime EntryDateTime { get; set; }
        public long EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string? Status { get; set; }
        public int total_row { get; set; }  
    }
}
