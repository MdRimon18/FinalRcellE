namespace Pms.Models.Entity.Settings
{
    public class Suppliers
    {
        public long SupplierId { get; set; }
        public Guid? SupplierKey { get; set; }
        public long? BranchId { get; set; }
        public string SupplrName { get; set; }
        public string MobileNo { get; set; }
        public string Email { get; set; }
        public string SuppOrgnznName { get; set; }
        public long CountryId { get; set; }
        public string StateName { get; set; }
        public long BusinessTypeId { get; set; }
        public string SupplrAddrssOne { get; set; }
        public string SupplrAddrssTwo { get; set; }
        public string DeliveryOffDay { get; set; }
        public string SupplrImgLink { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
