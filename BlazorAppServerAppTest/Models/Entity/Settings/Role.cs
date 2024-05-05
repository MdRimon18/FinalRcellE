using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity.Settings
{
    public class Role
    {
        public long RoleId { get; set; }
        public Guid? Rolekey { get; set; }

        [Required(ErrorMessage = "Role Name Name is required")]
        [StringLength(100, ErrorMessage = "Role Name Name must not exceed 100 characters")]
        public string RoleName { get; set; }
        public DateTime EntryDateTime { get; set; }
        public long EntryBy { get; set; }
        public DateTime? LastModifyDate { get; set; }
        public long? LastModifyBy { get; set; }
        public DateTime? DeletedDate { get; set; }
        public long? DeletedBy { get; set; }
        public string? Status { get; set; }
    }
}
