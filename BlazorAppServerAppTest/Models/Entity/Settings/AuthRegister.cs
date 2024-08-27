using System.ComponentModel.DataAnnotations;
namespace Pms.Models.Entity.Settings
{
    public class AuthRegister
    {
       [Required(ErrorMessage = " Name is required")]
        public string Name { get; set; }
       [Required(ErrorMessage = " Email Adress is required")]
        public string EmailAdress { get; set; }
       [Required(ErrorMessage = " Password is required")]
        public string Password { get; set; }
       [Required(ErrorMessage = " Confirm Password is required")]
        public string ConfirmPassword { get; set; }
        public bool RememberMe { get; set; }

    }
}
