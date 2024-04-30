namespace Pms.Models.Entity.Settings
{
    public class BillingPlan
    {
        public long BillingPlanId { get; set; }
        public Guid BillingPlanKey { get; set; }
        public int LanguageId { get; set; }
        public string BillingPlanName { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string? Status { get; set; }
    }
}
