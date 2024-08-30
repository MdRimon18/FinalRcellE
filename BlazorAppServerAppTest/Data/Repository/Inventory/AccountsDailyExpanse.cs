namespace Pms.Data.Repository.Inventory
{
    public class AccountsDailyExpanse
    {
        public long AccDailyExpanseId { get; set; } = 0; // Default to 0 for inserts
        public Guid? AccDailyExpanseKey { get; set; } = null; // Nullable for new records
        public int AccHeadId { get; set; }
        public decimal? Expense { get; set; } = null;
        public DateTime? Date { get; set; } = null;
        public string Remarks { get; set; }
        public DateTime? EntryDateTime { get; set; } = null;
        public long? EntryBy { get; set; } = null;
        public DateTime? LastModifyDate { get; set; } = null;
        public long? LastModifyBy { get; set; } = null;
        public DateTime? DeletedDate { get; set; } = null;
        public long? DeletedBy { get; set; } = null;
        public string Status { get; set; } = null;
        public int SuccessOrFailId { get; set; }
        public int total_row { get; set; }
    }
}
