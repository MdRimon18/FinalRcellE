using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class InvoiceType
    {
        public long InvoiceTypeId { get; set; }
        public Guid? InvoiceTypeKey { get; set; }
        public int LanguageId { get; set; }

        [Required(ErrorMessage = "InvoiceType Name is required")]
        [StringLength(100, ErrorMessage = "InvoiceType  Name must not exceed 50 characters")]
        
        public string InvoiceTypeName { get; set; }
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

