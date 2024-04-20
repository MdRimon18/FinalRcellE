namespace Pms.Models.Entity.Inventory
{
    public class StatusSettings
    {
        public class StatusSetting
        {
            public long StatusSettingId { get; set; }
            public Guid? StatusSettingKey { get; set; }
            public long BranchId { get; set; }
            public string StatusSettingName { get; set; }
            public string PageName { get; set; }
            public int? Position { get; set; }
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
