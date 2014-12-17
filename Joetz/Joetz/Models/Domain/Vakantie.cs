using System;
using System.ComponentModel.DataAnnotations;
using System.EnterpriseServices.Internal;
using DotNetOpenAuth.OpenId;

namespace Joetz.Models.Domain
{
    //Vakantie klasse
    public class Vakantie: Activiteit
    {
        //De vertrekdatum is verplicht
        [Display(Name = "Vertrek")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime VertrekDatum { get; set; }

        //De terugkeerdatum is verplicht
        [Display(Name = "Terug")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime TerugkeerDatum { get; set; }

        //Het verblijf is verplicht, en mag niet langer dan 30 characters zijn
        [Display(Name = "Verblijf")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(30, ErrorMessage = "{0} is te lang.")]
        public string AantalDagenNachten { get; set; }

        //Het vervoer is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Vervoer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.MultilineText)]
        public string Vervoerwijze { get; set; }

        //De formule is verplicht, en mag niet langer dan 50 characters zijn
        [Display(Name = "Formule")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Formule { get; set; }

        //De link is verplicht
        [Display(Name = "Link vakantie website Joetz")]
        [DataType(DataType.Url)]
        public string Link { get; set; }

        //De basisprijs is verplicht, en moet positief zijn
        [Display(Name = "Basisprijs")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Basisprijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "basisprijs niet gekend")]
        public Double BasisPrijs { get; set; }

        //De bond moyson ledenprijs is verplicht, en moet positief zijn
        [Display(Name = "Bond Moyson ledenprijs")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Bond Moyson ledenprijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "Bond Moyson ledenprijs niet gekend")]
        public Double BondMoysonLedenPrijs { get; set; }

        //De sterprijs voor 1 ouder is optioneel, en moet positief zijn
        [Display(Name = "Sterprijs - 1 ouder lid van Bond Moyson")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Sterprijs 1 ouder lid mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "sterprijs 1 ouder lid niet gekend")]
        public Double SterPrijs1Ouder { get; set; }

        //De sterprijs voor 2 ouders is optioneel, en moet positief zijn
        [Display(Name = "Sterprijs - 2 ouders lid van Bond Moyson")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Sterprijs 2 ouders lid mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "sterprijs 2 ouders lid niet gekend")]
        public Double SterPrijs2Ouders { get; set; }

        //Het inbegrepen in prijs is verplicht
        [Display(Name = "In de prijs inbegrepen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string InbegrepenPrijs { get; set; }

        //De minimumleeftijd is verplicht, en moet positief zijn
        [Display(Name = "Minimum leeftijd")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, 40, ErrorMessage = "Minimum leeftijd mag niet negatief zijn")]
        public int MinLeeftijd { get; set; }

        //De maximumleeftijd is verplicht, en moet positief zijn
        [Display(Name = "Maximum leeftijd")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, 40, ErrorMessage = "Maximum leeftijd mag niet negatief zijn")]
        public int MaxLeeftijd { get; set; }

        //Het maximum aantal deelnemers is verplicht, en moet positief zijn
        [Display(Name = "Maximum aantal deelnemers")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, Int32.MaxValue, ErrorMessage = "Maximum aantal deelnemers mag niet negatief zijn")]
        public int MaxAantalDeelnemers { get; set; }

        //Geeft de mogelijkheid om een nieuwe vakantie aan te maken
        public Vakantie() : base()
        {
            Id = "";
            VertrekDatum = new DateTime();
            TerugkeerDatum = new DateTime();
            AantalDagenNachten = "";
            Vervoerwijze = "";
            Formule = "";
            Link = "";
            BasisPrijs = 0.0;
            BondMoysonLedenPrijs = 0.0;
            SterPrijs1Ouder = 0.0;
            SterPrijs2Ouders = 0.0;
            InbegrepenPrijs = "";
            MinLeeftijd = 0;
            MaxLeeftijd = 0;
            MaxAantalDeelnemers = 0; 
        }
    }
}