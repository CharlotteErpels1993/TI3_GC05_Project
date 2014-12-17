using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Joetz.Models.Domain
{
    //Vorming klasse
    public class Vorming: Activiteit
    {
        //De betalingswijze is verplicht
        [Display(Name = "Betalingswijze")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string Betalingswijze { get; set; }

        //Het criteria van de deelnemers is verplicht
        [Display(Name = "Criteria waar de deelnemers aan moeten voldoen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string CriteriaDeelnemers { get; set; }

        //Het in prijs inbegrepen is verplicht
        [Display(Name = "In de prijs inbegrepen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string InbegrepenPrijs { get; set; }

        //De periodes zijn verplicht
        [Display(Name = "Periodes")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public IList<string> Periodes { get; set; }

        public string PeriodesInStringVorm
        {
            get
            {
                StringBuilder sb = new StringBuilder();
                foreach (string obj in Periodes)
                {
                    sb.Append("* " + obj + Environment.NewLine);
                }
                return sb.ToString();
            }
        }

        //De prijs is verplicht, en moet positief zijn
        [Display(Name = "Prijs")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Prijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "prijs niet gekend")]
        public Double Prijs { get; set; }

        //De tips zijn optioneel
        [Display(Name = "Tips")]
        [DataType(DataType.MultilineText)]
        public string Tips { get; set; }

        //De website locatie is optioneel
        [Display(Name = "Website locatie")]
        [DataType(DataType.Url)]
        public string WebsiteLocatie { get; set; }

        //Geeft de mogelijkheid om een nieuwe vorming aan te maken
        public Vorming() : base()
        {
            Betalingswijze = "";
            CriteriaDeelnemers = "";
            InbegrepenPrijs = "";
            Periodes = new List<String>();
            Prijs = 0.0;
            Tips = "";
            WebsiteLocatie = "";
        }
    }
}