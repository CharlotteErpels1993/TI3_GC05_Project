using System.ComponentModel.DataAnnotations;

namespace Joetz.Models.Domain
{
    public class Activiteit
    {
        public string Id { get; set; }

        [Display(Name = "Titel vakantie")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Titel { get; set; }

        [Display(Name = "Logies")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.MultilineText)]
        public string Locatie { get; set; }

        [Display(Name = "Beschrijving")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string KorteBeschrijving { get; set; }

        public Activiteit()
        {
            Id = "";
            Titel = "";
            Locatie = "";
            KorteBeschrijving = "";
        }
    }
}