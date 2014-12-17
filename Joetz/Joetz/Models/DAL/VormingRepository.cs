using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;
//Repository om gegevens van vormingen uit de database te halen en te bewerken
namespace Joetz.Models.DAL
{
    public class VormingRepository: IVormingRepository
    {
        //
        //Naam: GetVorming
        //
        //Werking: Haalt de vorming op uit de database
        //
        //Parameters:
        // - Het object om op te zoeken
        //
        //Return: de opgezochte vorming
        //
        public Vorming GetVorming(ParseObject vormingObject)
        {
            Vorming vorming = new Vorming();

            vorming.Id = vormingObject.ObjectId;
            vorming.Titel = vormingObject.Get<string>("titel");
            vorming.Locatie = vormingObject.Get<string>("locatie");
            vorming.KorteBeschrijving = vormingObject.Get<string>("korteBeschrijving");
            vorming.Betalingswijze = vormingObject.Get<string>("betalingswijze");
            vorming.CriteriaDeelnemers = vormingObject.Get<string>("criteriaDeelnemers");
            vorming.InbegrepenPrijs = vormingObject.Get<string>("inbegrepenInPrijs");
            vorming.InbegrepenPrijs = vormingObject.Get<string>("inbegrepenInPrijs");
            IList<string> periodes = vormingObject.Get<IList<string>>("periodes");
            string[] array = new string[periodes.Count];
            periodes.CopyTo(array, 0);
            vorming.Periodes = array;
            vorming.Prijs = vormingObject.Get<Double>("prijs");
            vorming.Tips = vormingObject.Get<string>("tips");
            vorming.WebsiteLocatie = vormingObject.Get<string>("websiteLocatie");

            return vorming;
        }

        //
        //Naam: FindBy
        //
        //Werking: Zoekt de vorming op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden vorming
        //
        public async Task<Vorming> FindBy(string vormingId)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vormingId);
            ParseObject vormingObject = await query.FirstAsync();

            var vorming = GetVorming(vormingObject);
            return vorming;
        }

        //
        //Naam: FindAll
        //
        //Werking: Haalt alle vormingen op uit de database en vult de objecten 1 voor 1 op
        //
        //
        //Return: de lijst van vormingen
        //
        public async Task<ICollection<Vorming>> FindAll()
        {
            var query = from v in ParseObject.GetQuery("Vorming")
                        orderby v.Get<string>("titel") ascending
                        select v;

            IEnumerable<ParseObject> objects = await query.FindAsync();

            ICollection<Vorming> vormingen = new List<Vorming>();
            Vorming vorming;

            foreach (ParseObject vormingObject in objects)
            {
                vorming = GetVorming(vormingObject);
                vormingen.Add(vorming);
            }

            return vormingen;
        }
        //
        //Naam: Add
        //
        //Werking: Voegt een vorming toe aan de database
        //
        //Parameters:
        // - De vorming om toe te voegen
        //
        //Return: bool om aan te geven dat het gedaan is
        //
        public async Task<bool> Add(Vorming vorming)
        {
            ParseObject vormingObject = new ParseObject("Vorming");

            vormingObject["titel"] = vorming.Titel;
            vormingObject["locatie"] = vorming.Locatie;
            vormingObject["korteBeschrijving"] = vorming.KorteBeschrijving;
            vormingObject["betalingswijze"] = vorming.Betalingswijze;
            vormingObject["criteriaDeelnemers"] = vorming.CriteriaDeelnemers;
            vormingObject["inbegrepenInPrijs"] = vorming.InbegrepenPrijs;
            string[] periodes = vorming.Periodes.ToString().Split(new Char[] {',', '.', ':', '\t' });
            vormingObject["periodes"] = periodes;
            vormingObject["prijs"] = vorming.Prijs;
            vormingObject["tips"] = vorming.Tips;
            vormingObject["websiteLocatie"] = vorming.WebsiteLocatie;

            await vormingObject.SaveAsync();

            return true;
        }
        //
        //Naam: Delete
        //
        //Werking: Verwijdert de vorming uit de database
        //
        //Parameters:
        // - De vorming om te verwijderen
        //
        //Return: boolean om aan te geven dat het verwijderen gedaan is
        //
        public async Task<bool> Delete(Vorming vorming)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vorming.Id);
            ParseObject vormingObject = await query.FirstAsync();

            await vormingObject.DeleteAsync();
            return true;
        }

        //
        //Naam: Update
        //
        //Werking: Verandert de vorming in de database
        //
        //Parameters:
        // - De vorming om te aan te passen
        //
        //Return: boolean om aan te geven dat het aanpassen gedaan is
        //
        public async Task<bool> Update(Vorming vorming)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vorming.Id);
            ParseObject vormingObject = await query.FirstAsync();

            vormingObject["titel"] = vorming.Titel;
            vormingObject["locatie"] = vorming.Locatie;
            vormingObject["korteBeschrijving"] = vorming.KorteBeschrijving;
            vormingObject["betalingswijze"] = vorming.Betalingswijze;
            vormingObject["criteriaDeelnemers"] = vorming.CriteriaDeelnemers;
            vormingObject["inbegrepenInPrijs"] = vorming.InbegrepenPrijs;
            //vormingObject["periodes"] = vorming.Periodes;
            vormingObject["prijs"] = vorming.Prijs;
            vormingObject["tips"] = vorming.Tips;
            vormingObject["websiteLocatie"] = vorming.WebsiteLocatie;

            await vormingObject.SaveAsync();

            return true;
        }
    }
}