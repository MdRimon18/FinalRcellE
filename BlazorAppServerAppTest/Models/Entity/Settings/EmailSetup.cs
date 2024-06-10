using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class EmailSetup
    {
        public int EmailSetupId { get; set; }
        public Guid EmailSetupkey { get; set; }
        public long BranchId { get; set; }
        [Required(ErrorMessage = "Email is required")]
        [StringLength(100, ErrorMessage = "Email must not exceed 100 characters")]
        public string FromEmail { get; set; }
        
        public string FromName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string BaseUrl { get; set; }
        public string ApiKey { get; set; }
        public long? PortNumber { get; set; }
        public bool IsDefault { get; set; }
        public DateTime EntryDateTime { get; set; }
        public long EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string Status { get; set; }
        public int total_row { get; set; }
    }
}
