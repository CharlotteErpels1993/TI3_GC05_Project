using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;

namespace Joetz.Models.DAL
{
    public class FeedbackRepository: IFeedbackRepository
    {
        private IVakantieRepository vakantieRepository = new VakantieRepository();
        public async Task<Feedback> GetFeedback(ParseObject feedbackObject)
        {
            
            Feedback feedback = new Feedback();

            feedback.Id = feedbackObject.ObjectId;
            feedback.Waardering = feedbackObject.Get<string>("waardering");
            feedback.Goedgekeurd = feedbackObject.Get<Boolean>("goedgekeurd");
            feedback.Vakantie = feedbackObject.Get<string>("vakantie");
            feedback.Score = feedbackObject.Get<int>("score");
            feedback.Datum = feedbackObject.Get<DateTime>("datum");
            feedback.Gebruiker = feedbackObject.Get<string>("gebruiker");
            var vak = FindByVakantie(feedback.Vakantie);
            Vakantie v = await vak;
            feedback.VakantieNaam = v.Titel;

            return feedback;

        }
        public async Task<Vakantie> FindByVakantie(string vakantieId)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantieId);
            ParseObject vakantieObject = await query.FirstAsync();

            return vakantieRepository.GetVakantie(vakantieObject);
        }


        public async Task<ICollection<Feedback>> FindAll()
        {
            var query = from f in ParseObject.GetQuery("Feedback")
                        orderby f.Get<string>("vakantie") ascending
                        select f;

            IEnumerable<ParseObject> objects = await query.FindAsync();

            ICollection<Feedback> feedbackLijst = new List<Feedback>();
            Feedback feedback;

            foreach (ParseObject feedbackObject in objects)
            {
                feedback = await GetFeedback(feedbackObject);
                feedbackLijst.Add(feedback);
            }

            return feedbackLijst;
        }

        public async Task<Feedback> FindBy(string feedbackId)
        {
            var query = ParseObject.GetQuery("Feedback").WhereEqualTo("objectId", feedbackId);
            ParseObject feedbackObject = await query.FirstAsync();

            var feedback = await GetFeedback(feedbackObject);
            return feedback;
        }
/*
        public async void Add(Feedback vakantie)
        {
            ParseObject vakantieObject = new ParseObject("Feedback");

            vakantieObject["goedgekeurd"] = vakantie.Titel;
            vakantieObject["locatie"] = vakantie.Locatie;
            vakantieObject["korteBeschrijving"] = vakantie.KorteBeschrijving;
            vakantieObject["aantalDagenNachten"] = vakantie.AantalDagenNachten;
            vakantieObject["basisPrijs"] = vakantie.BasisPrijs;
            vakantieObject["bondMoysonLedenPrijs"] = vakantie.BondMoysonLedenPrijs;
            vakantieObject["formule"] = vakantie.Formule;
            vakantieObject["link"] = vakantie.Link;
            vakantieObject["inbegrepenPrijs"] = vakantie.InbegrepenPrijs;
            vakantieObject["maxAantalDeelnemers"] = vakantie.MaxAantalDeelnemers;
            vakantieObject["minLeeftijd"] = vakantie.MinLeeftijd;
            vakantieObject["maxLeeftijd"] = vakantie.MaxLeeftijd;
            vakantieObject["sterPrijs1ouder"] = vakantie.SterPrijs1Ouder;
            vakantieObject["sterPrijs2ouders"] = vakantie.SterPrijs2Ouders;
            vakantieObject["terugkeerdatum"] = vakantie.TerugkeerDatum;
            vakantieObject["vertrekdatum"] = vakantie.VertrekDatum;
            vakantieObject["vervoerwijze"] = vakantie.Vervoerwijze;

            await vakantieObject.SaveAsync();
        }
        */
        public async void Delete(Feedback feedback)
        {
            var query = ParseObject.GetQuery("Feedback").WhereEqualTo("objectId", feedback.Id);
            ParseObject feedbackObject = await query.FirstAsync();

            await feedbackObject.DeleteAsync();
        }

        public async Task<Boolean> Update(Feedback feedback)
        {
            var query = ParseObject.GetQuery("Feedback").WhereEqualTo("objectId", feedback.Id);
            ParseObject feedbackObject = await query.FirstAsync();
            if(feedback.Goedgekeurd)
            {
                feedbackObject["goedgekeurd"] = false;
            }
            else
            {
                feedbackObject["goedgekeurd"] = true;
            }
            
            await feedbackObject.SaveAsync();
            return true;
        }
    }
}