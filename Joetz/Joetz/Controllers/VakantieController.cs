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
        public async Task<ActionResult> Create(Vakantie vakantie)
        {
            if (ModelState.IsValid)
            {
                await vakantieRepository.Add(vakantie);
                TempData["Info"] = "Vakantie " + vakantie.Titel + " is toegevoegd";
                return RedirectToAction("Index");    
            }
            return View(vakantie);
        }

        public async Task<ActionResult> Edit(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View(vakantie);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(Vakantie v)
        {
            
            await vakantieRepository.Update(v);
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
            await vakantieRepository.Delete(vakantie);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Details(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View("Details", vakantie);
        }

    }
}
