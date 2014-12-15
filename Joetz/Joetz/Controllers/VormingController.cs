using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Joetz.Models.DAL;
using Joetz.Models.Domain;

namespace Joetz.Controllers
{
    public class VormingController : Controller
    {
        private IVormingRepository vormingRepository;

        public VormingController()
        {
            this.vormingRepository = new VormingRepository();
        }

        public VormingController(IVormingRepository vormingRepository)
        {
            this.vormingRepository = vormingRepository;
        }

        public async Task<ActionResult> Index()
        {
            var vormingenTask = vormingRepository.FindAll();
            IEnumerable<Vorming> vormingen = await vormingenTask;
            return View(vormingen);
        }

        public ActionResult Create()
        {
            return View(new Vorming());
        }

        [HttpPost]
        public ActionResult Create(Vorming vorming)
        {
            if (ModelState.IsValid)
            {
                vormingRepository.Add(vorming);
                TempData["Info"] = "Vorming " + vorming.Titel + " is toegevoegd";
                return RedirectToAction("Index");
            }
            return View(vorming);
        }

        public async Task<ActionResult> Edit(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View("Create", vorming);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(string id, FormCollection formValues)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            UpdateModel(vorming, formValues.ToValueProvider());
            vormingRepository.Update(vorming);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Delete(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View(vorming);
        }

        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            vormingRepository.Delete(vorming);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Details(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View("Details", vorming);
        }
    }
}
