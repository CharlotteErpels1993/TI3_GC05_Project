using System;
using System.Collections.Generic;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class VormingRepository: IVormingRepository
    {
        public Vorming GetVorming(ParseObject vormingObject)
        {
            Vorming vorming = new Vorming("test");

            vorming.Id = vormingObject.ObjectId;
            vorming.Titel = vormingObject.Get<string>("titel");
            vorming.Locatie = vormingObject.Get<string>("locatie");
            vorming.KorteBeschrijving = vormingObject.Get<string>("korteBeschrijving");
            vorming.Betalingswijze = vormingObject.Get<string>("betalingswijze");
            vorming.CriteriaDeelnemers = vormingObject.Get<string>("criteriaDeelnemers");
            vorming.InbegrepenPrijs = vormingObject.Get<string>("inbegrepenInPrijs");
            //vorming.Periodes = vormingObject.Get<string>("periodes"); IS ARRAY!!!!!
            vorming.Prijs = vormingObject.Get<Double>("prijs");
            vorming.Tips = vormingObject.Get<string>("tips");
            vorming.WebsiteLocatie = vormingObject.Get<string>("websiteLocatie");

            return vorming;
        }

        public Vorming FindBy(string vormingId)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vormingId);
            ParseObject vormingObject = query.FirstAsync().Result;

            var vorming = GetVorming(vormingObject);
            return vorming;
        }

        public IList<Vorming> FindAll()
        {
            var query = ParseObject.GetQuery("Vorming");
            IEnumerable<ParseObject> vormingObjects = query.FindAsync().Result;

            IList<Vorming> vormingen = new Vorming[] { };
            Vorming vorming;

            foreach (ParseObject vormingObject in vormingObjects)
            {
                vorming = GetVorming(vormingObject);
                vormingen.Add(vorming);
            }

            return vormingen;
        }

        public void Add(Vorming vorming)
        {
            ParseObject vormingObject = new ParseObject("Vorming");

            vormingObject["titel"] = vorming.Titel;
            vormingObject["locatie"] = vorming.Locatie;
            vormingObject["korteBeschrijving"] = vorming.KorteBeschrijving;
            vormingObject["betalingswijze"] = vorming.Betalingswijze;
            vormingObject["criteriaDeelnemers"] = vorming.CriteriaDeelnemers;
            vormingObject["inbegrepenInPrijs"] = vorming.InbegrepenPrijs;
            //vormingObject["periodes"] = vorming.Periodes; IS ARRAY!!!!!
            vormingObject["prijs"] = vorming.Prijs;
            vormingObject["tips"] = vorming.Tips;
            vormingObject["websiteLocatie"] = vorming.WebsiteLocatie;

            vormingObject.SaveAsync();
        }

        public void Delete(Vorming vorming)
        {
            var query = ParseObject.GetQuery("Vorming").WhereEqualTo("objectId", vorming.Id);
            ParseObject vormingObject = query.FirstAsync().Result;

            vormingObject.DeleteAsync();
        }
    }
}