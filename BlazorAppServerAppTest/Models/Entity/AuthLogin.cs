using System.ComponentModel.DataAnnotations;

namespace Pms.Models.Entity
{
    public class AuthLogin
    {
        [Required(ErrorMessage = " Email Adress is required")]
        public string EmailAdress { get; set; }
        [Required(ErrorMessage = " Password is required")]
        public string Password { get; set; }      
        public bool RememberMe { get; set; } = false;
    }
}
