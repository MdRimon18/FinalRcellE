namespace Pms.Models.Entity.Inventory
{
    public class Currencies
    {
        public class Currency
        {
            public long CurrencyId { get; set; }
            public Guid? CurrencyKey { get; set; }
            public long BranchId { get; set; }
            public int LanguageId { get; set; }
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
        }
    }
}
