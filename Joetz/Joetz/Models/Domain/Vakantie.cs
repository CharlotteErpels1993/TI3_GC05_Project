using System;
using System.ComponentModel.DataAnnotations;
using System.EnterpriseServices.Internal;
using DotNetOpenAuth.OpenId;

namespace Joetz.Models.Domain
{
    public class Vakantie: Activiteit
    {
        [Display(Name = "Vertrek")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime VertrekDatum { get; set; }

        [Display(Name = "Terug")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime TerugkeerDatum { get; set; }

        [Display(Name = "Verblijf")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(30, ErrorMessage = "{0} is te lang.")]
        public string AantalDagenNachten { get; set; }

        [Display(Name = "Vervoer")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        [DataType(DataType.MultilineText)]
        public string Vervoerwijze { get; set; }

        [Display(Name = "Formule")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [StringLength(50, ErrorMessage = "{0} is te lang.")]
        public string Formule { get; set; }

        [Display(Name = "Link vakantie website Joetz")]
        [DataType(DataType.Url)]
        //[DataType(DataType.MultilineText)]
        public string Link { get; set; }

        [Display(Name = "Basisprijs")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Basisprijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "basisprijs niet gekend")]
        public Double BasisPrijs { get; set; }

        [Display(Name = "Bond Moyson ledenprijs")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Bond Moyson ledenprijs mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "Bond Moyson ledenprijs niet gekend")]
        public Double BondMoysonLedenPrijs { get; set; }

        [Display(Name = "Sterprijs - 1 ouder lid van Bond Moyson")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Sterprijs 1 ouder lid mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "sterprijs 1 ouder lid niet gekend")]
        public Double SterPrijs1Ouder { get; set; }

        [Display(Name = "Sterprijs - 2 ouders lid van Bond Moyson")]
        [Range(0.0, Double.MaxValue, ErrorMessage = "Sterprijs 2 ouders lid mag niet negatief zijn")]
        [DisplayFormat(DataFormatString = "{0:F} euro", NullDisplayText = "sterprijs 2 ouders lid niet gekend")]
        public Double SterPrijs2Ouders { get; set; }

        [Display(Name = "In de prijs inbegrepen")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [DataType(DataType.MultilineText)]
        public string InbegrepenPrijs { get; set; }

        [Display(Name = "Minimum leeftijd")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, 40, ErrorMessage = "Minimum leeftijd mag niet negatief zijn")]
        public int MinLeeftijd { get; set; }

        [Display(Name = "Maximum leeftijd")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, 40, ErrorMessage = "Maximum leeftijd mag niet negatief zijn")]
        public int MaxLeeftijd { get; set; }

        [Display(Name = "Maximum aantal deelnemers")]
        [Required(ErrorMessage = "{0} is verplicht")]
        [Range(0, Int32.MaxValue, ErrorMessage = "Maximum aantal deelnemers mag niet negatief zijn")]
        public int MaxAantalDeelnemers { get; set; }

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