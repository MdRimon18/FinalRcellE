using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Pms.Models.Entity.Settings
{
    public class User
    {
        public long UserId { get; set; }
        public Guid? UserKey { get; set; }
        [Required(ErrorMessage = "User Name is Required")]
        public string? UserName { get; set; }
        [Required(ErrorMessage = "User Phone No is Required")]
        public string? UserPhoneNo { get; set; }
        [Required(ErrorMessage = "User Password is Required")]
        public string? UserPassword { get; set; }
        public string UserDesignation { get; set; }
        public string UserImgLink { get; set; }
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
