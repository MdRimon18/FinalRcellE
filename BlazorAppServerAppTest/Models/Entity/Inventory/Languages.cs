namespace Pms.Models.Entity.Inventory
{
    public class Languages
    {
        public class Language
        {
            public int LanguageId { get; set; }
            public Guid? LanguageKey { get; set; }
            public string LanguageName { get; set; }
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
