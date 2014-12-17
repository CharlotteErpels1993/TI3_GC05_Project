using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Joetz.Models.DAL;
using Joetz.Models.Domain;
//Geeft de gebruiker de mogelijkheid om vormingen te beheren
namespace Joetz.Controllers
{
    public class VormingController : Controller
    {
        //Repository
        private IVormingRepository vormingRepository;

        public VormingController()
        {
            this.vormingRepository = new VormingRepository();
        }

        public VormingController(IVormingRepository vormingRepository)
        {
            this.vormingRepository = vormingRepository;
        }
        //
        //Naam: Index
        //
        //Werking: Stuurt de gebruiker naar een overzicht van vormingen
        //
        //
        //Return: De actie naar login indien de gebruiker niet ingelogged is of de view met de vormingen
        //
        public async Task<ActionResult> Index()
        {
            if(Parse.ParseUser.CurrentUser != null)
            {
                var vormingenTask = vormingRepository.FindAll();
                IEnumerable<Vorming> vormingen = await vormingenTask;
                return View(vormingen);
            }
            else
            {
                return RedirectToAction("Login", "Account", null);
            }
        }
        //
        //Naam: Create
        //
        //Werking: Stuurt de gebruiker naar een view om nieuwe vorming aan te maken
        //
        //
        //Return: De view om nieuwe vorming toe te voegen
        //
        public ActionResult Create()
        {
            return View(new Vorming());
        }
        //
        //Naam: Create
        //
        //Werking: Maakt de vorming aan en voegt deze toe aan de database
        //
        //Parameters:
        // - De vorming om toe te voegen
        //
        //Return: de view indien fouten, stuurt de gebruiker door naar index
        //
        [HttpPost]
        public async Task<ActionResult> Create(Vorming vorming)
        {
            if (ModelState.IsValid)
            {
                await vormingRepository.Add(vorming);
                TempData["Info"] = "Vorming " + vorming.Titel + " is toegevoegd";
                return RedirectToAction("Index");
            }
            return View(vorming);
        }
        //
        //Naam: Edit
        //
        //Werking: geeft een view met de vorming om aan te passen
        //
        //Parameters:
        // - Het id van de aan te passen vorming
        //
        //Return: de view met de vorming om aan te passen
        //
        public async Task<ActionResult> Edit(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View(vorming);
        }
        //
        //Naam: Edit
        //
        //Werking: Past de vorming aan in de database
        //
        //Parameters:
        // - De aangepaste vorming
        //
        //Return: Stuurt de gebruiker terug naar de index
        //
        [HttpPost]
        public async Task<ActionResult> Edit(Vorming v)
        {
            if (ModelState.IsValid)
            {
                await vormingRepository.Update(v);
                return RedirectToAction("Index");
            }

            return View(v);
        }
        //
        //Naam: Delete
        //
        //Werking: Stuurt de gebruiker door naar de pagina om delete te bevestigen
        //
        //Parameters:
        // - id van de te verwijderen vorming
        //
        //Return: de view om delete te bevestigen
        //
        public async Task<ActionResult> Delete(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View(vorming);
        }
        //Naam: Delete
        //
        //Werking: Verwijdert de vorming uit de database
        //
        //Parameters:
        // - id van de te verwijderen vorming
        //
        //Return: de gebruiker wordt naar de index teruggestuurd
        //
        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            await vormingRepository.Delete(vorming);
            return RedirectToAction("Index");
        }
        //Naam: Details
        //
        //Werking: Stuurt de gebruiker naar de detailpagina van een vorming
        //
        //Parameters:
        // - id van de te bekijken vorming
        //
        //Return: De detailview
        //   
        public async Task<ActionResult> Details(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View("Details", vorming);
        }
    }
}
