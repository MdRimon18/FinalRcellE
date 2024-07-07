using Microsoft.AspNetCore.Components.Forms;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Pms.Models.Entity.Settings
{
    public class Customers
    {
        public long CustomerId { get; set; }
        public Guid? CustomerKey { get; set; }
        public long? BranchId { get; set; }
        [Required(ErrorMessage = "Customer Name is Required")]
        [StringLength(100, ErrorMessage = "Customer Name cannot exceed 100 characters")]
        // [RegularExpression("^[a-zA-Z]*$", ErrorMessage = "Customer Name can only contain letters")]
        public string CustomerName { get; set; }

        [Required(ErrorMessage = "Mobile Number is Required")]
        [StringLength(100, ErrorMessage = "Mobile Number cannot exceed 100 characters")]
        public string MobileNo { get; set; }

       // [Required(ErrorMessage = "Email is required")]
       //[EmailAddress(ErrorMessage = "Invalid email address")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Country is Required")]
        public long? CountryId { get; set; }
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

        [NotMapped]
        public int total_row { get; set; } = 0;
        public string? CountryName { get; set; }
        
    }
}
