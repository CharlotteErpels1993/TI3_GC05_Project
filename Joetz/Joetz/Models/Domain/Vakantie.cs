using System;
using System.EnterpriseServices.Internal;
using DotNetOpenAuth.OpenId;

namespace Joetz.Models.Domain
{
    public class Vakantie: Activiteit
    {
        public DateTime VertrekDatum { get; set; }
        public DateTime TerugkeerDatum { get; set; }
        public string AantalDagenNachten { get; set; }
        public string Vervoerwijze { get; set; }
        public string Formule { get; set; }
        public string Link { get; set; }
        public Double BasisPrijs { get; set; }
        public Double BondMoysonLedenPrijs { get; set; }
        public Double SterPrijs1Ouder { get; set; }
        public Double SterPrijs2Ouders { get; set; }
        public string InbegrepenPrijs { get; set; }
        public int MinLeeftijd { get; set; }
        public int MaxLeeftijd { get; set; }
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