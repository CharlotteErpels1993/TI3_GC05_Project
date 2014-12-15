using System;
using System.ComponentModel.DataAnnotations;
using System.EnterpriseServices.Internal;
using DotNetOpenAuth.OpenId;

namespace Joetz.Models.Domain
{
    public class Feedback: Activiteit
    {
        [Display(Name = "Waardering")]
        public string Waardering { get; set; }

        [Display(Name = "Goedgekeurd")]
        public Boolean Goedgekeurd { get; set; }

        [Display(Name = "vakantie")]
        public string Vakantie { get; set; }

        [Display(Name = "Score")]
        public int Score { get; set; }

        [Display(Name = "Gebruiker")]
        public string Gebruiker { get; set; }

        [Display(Name = "vakantienaam")]
        public String VakantieNaam { get; set; }

        [Display(Name = "Datum")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime Datum { get; set; }

       
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