using System;
using System.Collections.Generic;

namespace Joetz.Models.Domain
{
    public class Vorming: Activiteit
    {
        public string Betalingswijze { get; set; }
        public string CriteriaDeelnemers { get; set; }
        public string InbegrepenPrijs { get; set; }
        public IList<string> Periodes { get; set; }
        public Double Prijs { get; set; }
        public string Tips { get; set; }
        public string WebsiteLocatie { get; set; }

        public Vorming(string id) : base(id)
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