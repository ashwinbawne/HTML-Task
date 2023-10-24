using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace RegistrationPage1.Models
{
    public class Reg
    {
        public long SerialNo { get; set; }
        
        [Required] 
        public int Id { get; set; }

        [Required(ErrorMessage = "First Name is required")]
        public string Firstname { get; set; }

        [Required(ErrorMessage = "Last Name is required")]
        public string Lastname { get; set; }

        [Required(ErrorMessage = "Date of birth is required")]
        public string? Dateofbirth { get; set; }

        
        public string Hobbies { get; set; }

        [Required(ErrorMessage = "Hobbie  is required")]
        public List<string> Hobbie { get; set; }
        
       

        public string Gender { get; set; }

        [Required(ErrorMessage = "State is required")]

        public string State { get; set; }


        public int StateID { get; set; }
        public List<SelectListItem> StateData { get; set; }

        [Required(ErrorMessage = "City is required")]
        public string City { get; set; }

        public int CityID { get; set; }

        public List<SelectListItem> CityData { get; set; }
        public string? UploadImage { get; set; }

        public string? UploadPdf { get; set; }

        public IFormFile? FormImageFile { get; set; }

        public IFormFile? FormPdfFile { get; set; }




    }
}
