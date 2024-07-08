using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pms.Models.Entity.Settings
{
    public class Suppliers
    {
        public long SupplierId { get; set; }
        public Guid? SupplierKey { get; set; }
        public long? BranchId { get; set; }
        [Required(ErrorMessage = "Supplier Name is Required")]
        [StringLength(100, ErrorMessage = "Supplier Name cannot exceed 100 characters")]
        public string SupplrName { get; set; }
        [Required(ErrorMessage = "Mobile Number is Required")]
        [StringLength(100, ErrorMessage = "Mobile Number cannot exceed 100 characters")]
        public string MobileNo { get; set; }
        [Required(ErrorMessage = "Email is required")]
        [EmailAddress(ErrorMessage = "Invalid email address")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Organization Name is Required")]
        [StringLength(200, ErrorMessage = "Organization Name cannot exceed 200 characters")]
        public string SuppOrgnznName { get; set; }
        [Required(ErrorMessage = "Country is Required")]
        public long? CountryId { get; set; }

        [Required(ErrorMessage = "State Name is Required")]
        [StringLength(100, ErrorMessage = "State Name cannot exceed 100 characters")]
        public string StateName { get; set; }
        [Required(ErrorMessage = "Business type is Required")]
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

        [NotMapped]
        public int total_row { get; set; } = 0;
    }
}
