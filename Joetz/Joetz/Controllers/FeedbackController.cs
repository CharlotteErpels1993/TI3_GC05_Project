using Joetz.Models.DAL;
using Joetz.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Controllers
{
    public class FeedbackController : Controller
    {
        private IFeedbackRepository feedbackRepository;

        public FeedbackController()
        {
            this.feedbackRepository = new FeedbackRepository();
        }

        public FeedbackController(IFeedbackRepository feedbackRepository)
        {
            this.feedbackRepository = feedbackRepository;
        }

        public async Task<ActionResult> Index()
        {
            var feedbackTask = feedbackRepository.FindAll();
            IEnumerable<Feedback> feedback = await feedbackTask;
            return View(feedback);
        }
/*
        public async Task<ActionResult> Edit(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View("Create", vakantie);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(string id, FormCollection formValues)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            UpdateModel(vakantie, formValues.ToValueProvider());
            vakantieRepository.Update(vakantie);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Delete(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View(vakantie);
        }

        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            vakantieRepository.Delete(vakantie);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Details(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View("Details", vakantie);
        }*/
    }
}
