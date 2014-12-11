using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Joetz.Models.Domain
{
    public class Vorming: Activiteit
    {
        [Display(Name = "Betalingswijze")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string Betalingswijze { get; set; }

        [Display(Name = "Criteria waar de deelnemers aan moeten voldoen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string CriteriaDeelnemers { get; set; }

        [Display(Name = "In de prijs inbegrepen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string InbegrepenPrijs { get; set; }

        [Display(Name = "Periodes")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public IList<string> Periodes { get; set; }

        [Display(Name = "Prijs")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Prijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "prijs niet gekend")]
        public Double Prijs { get; set; }

        [Display(Name = "Tips")]
        [DataType(DataType.MultilineText)]
        public string Tips { get; set; }

        [Display(Name = "Website locatie")]
        [DataType(DataType.Url)]
        public string WebsiteLocatie { get; set; }

        public Vorming() : base()
        {
            Betalingswijze = "";
            CriteriaDeelnemers = "";
            InbegrepenPrijs = "";
            Periodes = new List<string>();
            Prijs = 0.0;
            Tips = "";
            WebsiteLocatie = "";
        }
    }
}