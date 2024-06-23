namespace Pms.Models.Entity.Settings
{
    public class Customers
    {
        public long CustomerId { get; set; }
        public Guid? CustomerKey { get; set; }
        public long? BranchId { get; set; }
        public string CustomerName { get; set; }
        public string MobileNo { get; set; }
        public string Email { get; set; }
        public long CountryId { get; set; }
        public string StateName { get; set; }
        public string CustAddrssOne { get; set; }
        public string CustAddrssTwo { get; set; }
        public string Occupation { get; set; }
        public string OfficeName { get; set; }
        public string CustImgLink { get; set; }
        public DateTime? EntryDateTime { get; set; }
        public long? EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
    }
}
