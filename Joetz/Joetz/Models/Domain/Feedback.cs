using System;
using System.ComponentModel.DataAnnotations;
using System.EnterpriseServices.Internal;
using DotNetOpenAuth.OpenId;

namespace Joetz.Models.Domain
{
    //Feedback klasse
    public class Feedback: Activiteit
    {
        //De waardering is verplicht
        [Display(Name = "Waardering")]
        public string Waardering { get; set; }

        //De goedkeuring boolean
        [Display(Name = "Goedgekeurd")]
        public Boolean Goedgekeurd { get; set; }

        //De vakantie
        [Display(Name = "vakantie")]
        public string Vakantie { get; set; }

        //De score
        [Display(Name = "Score")]
        public int Score { get; set; }

        //De gebruiker
        [Display(Name = "Gebruiker")]
        public string Gebruiker { get; set; }

        //De vakantieNaam
        [Display(Name = "vakantienaam")]
        public String VakantieNaam { get; set; }

        //De datum
        [Display(Name = "Datum")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime Datum { get; set; }

       //Geeft de mogelijkheid een nieuwe feedback aan te maken, niet ondersteund op de site
        public Feedback() : base()
        {
            Id = "";
            Waardering = "";
            Vakantie = "";
            VakantieNaam = "";
            Gebruiker = "";
            Score = 0;
            Datum = new DateTime();
            Goedgekeurd = false;
        }
    }
}