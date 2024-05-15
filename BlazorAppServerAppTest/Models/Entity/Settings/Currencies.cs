using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class ProductSize
    {
        public long CurrencyId { get; set; }
        public Guid? CurrencyKey { get; set; }
       
        public int LanguageId { get; set; }

        [Required(ErrorMessage = "Currency Name is required")]
        [StringLength(100, ErrorMessage = "Currency Name must not exceed 50 characters")]
        public string CurrencyName { get; set; }
        public string CurrencyCode { get; set; }
        public string CurrencyShortName { get; set; }
        public string Symbol { get; set; }
        public decimal ExchangeRate { get; set; }
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

