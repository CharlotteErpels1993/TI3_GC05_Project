using Joetz.Models.DAL;
using Joetz.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
//Geeft de mogelijkheid feedback goed te keuren en te verwijderen
namespace Joetz.Controllers
{
    public class FeedbackController : Controller
    {
        //Repository
        private IFeedbackRepository feedbackRepository;

        public FeedbackController()
        {
            this.feedbackRepository = new FeedbackRepository();
        }

        public FeedbackController(IFeedbackRepository feedbackRepository)
        {
            this.feedbackRepository = feedbackRepository;
        }
        //
        //Naam: Index
        //
        //Werking: Stuurt de gebruiker naar een overzicht van feedback
        //
        //
        //Return: De actie naar login indien de gebruiker niet ingelogged is of de view met de feedback
        //
        public async Task<ActionResult> Index()
        {
            var feedbackTask = feedbackRepository.FindAll();
            IEnumerable<Feedback> feedback = await feedbackTask;
            return View(feedback);
        }

        //
        //Naam: Edit
        //
        //Werking: Geeft de gebruiker de mogelijkheid om feedback goed te keuren
        //
        //
        //Return: De gebruiker wordt teruggestuurd naar de index
        //
        public async Task<ActionResult> Edit(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            await feedbackRepository.Update(feedback);
            return RedirectToAction("Index");
        }

        //
        //Naam: Delete
        //
        //Werking: Stuurt de gebruiker door naar de pagina om delete te bevestigen
        //
        //Parameters:
        // - id van de te verwijderen feedback
        //
        //Return: de view om delete te bevestigen
        //       
        public async Task<ActionResult> Delete(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            return View(feedback);
        }
        //Naam: Delete
        //
        //Werking: Verwijdert de feedback uit de database
        //
        //Parameters:
        // - id van de te verwijderen feedback
        //
        //Return: de gebruiker wordt naar de index teruggestuurd
        //
        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            await feedbackRepository.Delete(feedback);
            return RedirectToAction("Index");
        }
        //Naam: Details
        //
        //Werking: Stuurt de gebruiker naar de detailpagina van een feedback
        //
        //Parameters:
        // - id van de te bekijken feedback
        //
        //Return: De detailview
        //        
        public async Task<ActionResult> Details(string id)
        {
            var feedbackTask = feedbackRepository.FindBy(id);
            Feedback feedback = await feedbackTask;
            return View("Details", feedback);
        }
    }
}
