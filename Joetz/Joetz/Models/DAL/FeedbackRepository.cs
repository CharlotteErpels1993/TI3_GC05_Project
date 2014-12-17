using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Joetz.Models.Domain;
using Parse;
//Repository om gegevens van administratoren uit de database te halen en te bewerken
namespace Joetz.Models.DAL
{
    public class FeedbackRepository: IFeedbackRepository
    {
        private IVakantieRepository vakantieRepository = new VakantieRepository();

        //
        //Naam: GetFeedback
        //
        //Werking: Haalt de feedback op uit de database
        //
        //Parameters:
        // - Het object om op te zoeken
        //
        //Return: de opgezochte feedback
        //
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
        //
        //Naam: FindByVakantie
        //
        //Werking: Zoekt de bijhorende vakantienaam op van de feedback op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden vakantie
        //
        public async Task<Vakantie> FindByVakantie(string vakantieId)
        {
            var query = ParseObject.GetQuery("Vakantie").WhereEqualTo("objectId", vakantieId);
            ParseObject vakantieObject = await query.FirstAsync();

            return vakantieRepository.GetVakantie(vakantieObject);
        }

        //
        //Naam: FindAll
        //
        //Werking: Haalt alle feedback op uit de database en vult de objecten 1 voor 1 op
        //
        //
        //Return: de lijst van feedback
        //
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

        //
        //Naam: FindBy
        //
        //Werking: Zoekt de feedback op basis van de id
        //
        //Parameters:
        // - id om op te zoeken
        //
        //Return: de gevonden feedback
        //
        public async Task<Feedback> FindBy(string feedbackId)
        {
            var query = ParseObject.GetQuery("Feedback").WhereEqualTo("objectId", feedbackId);
            ParseObject feedbackObject = await query.FirstAsync();

            var feedback = await GetFeedback(feedbackObject);
            return feedback;
        }
        //
        //Naam: Delete
        //
        //Werking: Verwijdert de feedback uit de database
        //
        //Parameters:
        // - De feedback om te verwijderen
        //
        //Return: boolean om aan te geven dat het verwijderen gedaan is
        //
        public async Task<bool> Delete(Feedback feedback)
        {
            var query = ParseObject.GetQuery("Feedback").WhereEqualTo("objectId", feedback.Id);
            ParseObject feedbackObject = await query.FirstAsync();

            await feedbackObject.DeleteAsync();
            return true;
        }

        //
        //Naam: Update
        //
        //Werking: verandert de status van feedback van afgekeurd naar goedgekeurd
        //
        //Parameters:
        // - De feedback om goed te keuren
        //
        //Return: boolean om aan te geven dat het updaten gedaan is
        //
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