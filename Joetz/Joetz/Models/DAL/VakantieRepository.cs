using System.Data.Entity;
using System.Linq;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class VakantieRepository: IVakantieRepository
    {
        //private context????
        private DbSet<ParseObject> vakantiesObjects;
        private DbSet<Vakantie> vakanties; 

        public Vakantie FindBy(string vakantieId)
        {
            return vakanties.Find(vakantieId);
        }

        public IQueryable<Vakantie> FindAll()
        {
            return vakanties.OrderBy(v => v.Titel);
        }

        public void Add(Vakantie vakantie)
        {
            ParseObject v = new ParseObject("Vakantie");

            v["titel"] = vakantie.Titel;
            v["aantalDagenNachten"] = vakantie.AantalDagenNachten;
            v["basisprijs"] = vakantie.BasisPrijs;
            v["locatie"] = vakantie.Locatie;
            v["korteBeschrijving"] = vakantie.KorteBeschrijving;
            v["vertrekdatum"] = vakantie.VertrekDatum;
            v["terugkeerdatum"] = vakantie.TerugkeerDatum;
            v["vervoerwijze"] = vakantie.Vervoerwijze;
            v["formule"] = vakantie.Formule;
            v["link"] = vakantie.Link;
            v["basisprijs"] = vakantie.BasisPrijs;
            v["bondMoysonLedenPrijs"] = vakantie.BondMoysonLedenPrijs;
            v["sterPrijs1Ouder"] = vakantie.SterPrijs1Ouder;
            v["sterPrijs2Ouders"] = vakantie.SterPrijs2Ouders;


            vakanties.Add(vakantie);
        }

        public void Delete(Vakantie vakantie)
        {
            vakanties.Remove(vakantie);
        }

        public void SaveChanges()
        {
            
        }
    }
}