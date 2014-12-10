using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Joetz.Models.DAL;
using Joetz.Models.Domain;

namespace Joetz.Controllers
{
    public class VakantieController : Controller
    {
        private IVakantieRepository vakantieRepository;

        public VakantieController()
        {
            this.vakantieRepository = new VakantieRepository();
        }

        public VakantieController(IVakantieRepository vakantieRepository)
        {
            this.vakantieRepository = vakantieRepository;
        }

        public async Task<ActionResult> Index()
        {
            var vakantiesTask = vakantieRepository.FindAll();
            IEnumerable<Vakantie> vakanties = await vakantiesTask;
            return View(vakanties);
        }

        public ActionResult Create()
        {
            return View(new Vakantie());
        }

        [HttpPost]
        public ActionResult Create(Vakantie vakantie)
        {
            if (ModelState.IsValid)
            {
                vakantieRepository.Add(vakantie);
                TempData["Info"] = "Vakantie " + vakantie.Titel + " is gecreëerd";
                return RedirectToAction("Index");    
            }
            return View(vakantie);
        }

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
    }
}
