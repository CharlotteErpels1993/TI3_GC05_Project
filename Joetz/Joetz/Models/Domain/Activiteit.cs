using System.ComponentModel.DataAnnotations;

namespace Joetz.Models.Domain
{
    //activiteit klasse
    public class Activiteit
    {
        //De activiteit id
        public string Id { get; set; }

        //De titel is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Titel")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Titel { get; set; }

        //De locatie is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Locatie")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.MultilineText)]
        public string Locatie { get; set; }

        //De beschrijving is verplicht
        [Display(Name = "Beschrijving")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string KorteBeschrijving { get; set; }

        //Mogelijkheid geven om nieuwe activiteit aan te maken
        public Activiteit()
        {
            Id = "";
            Titel = "";
            Locatie = "";
            KorteBeschrijving = "";
        }
    }
}