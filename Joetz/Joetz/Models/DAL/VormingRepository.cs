using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class VormingRepository: IVormingRepository
    {
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

        public async Task<Vorming> FindBy(string vormingId)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vormingId);
            ParseObject vormingObject = await query.FirstAsync();

            var vorming = GetVorming(vormingObject);
            return vorming;
        }

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

        public async Task<bool> Delete(Vorming vorming)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vorming.Id);
            ParseObject vormingObject = await query.FirstAsync();

            await vormingObject.DeleteAsync();
            return true;
        }

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