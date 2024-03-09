using System.ComponentModel.DataAnnotations;

namespace Pms.Models
{
    // Example model class
    public class Person
    {
        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Range(18, 99, ErrorMessage = "Age must be between 18 and 99")]
        public int Age { get; set; }
    }

}
