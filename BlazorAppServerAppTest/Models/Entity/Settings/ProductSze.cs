﻿namespace Pms.Models.Entity.Settings
{
    public class ProductSze
    {
        public long ProductSizeId { get; set; }
        public Guid? ProductSizeKey { get; set; }
        public int LanguageId { get; set; }
        public string ProductSizeName { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
        public int total_row { get; set; }  
    }
}
