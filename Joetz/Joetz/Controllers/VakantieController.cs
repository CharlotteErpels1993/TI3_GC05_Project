using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Joetz.Models.DAL;
using Joetz.Models.Domain;
//Geeft de gebruiker de mogelijkheid om vakanties te beheren
namespace Joetz.Controllers
{
    public class VakantieController : Controller
    {
        //repository
        private IVakantieRepository vakantieRepository;

        public VakantieController()
        {
            this.vakantieRepository = new VakantieRepository();
        }

        public VakantieController(IVakantieRepository vakantieRepository)
        {
            this.vakantieRepository = vakantieRepository;
        }
        //
        //Naam: Index
        //
        //Werking: Stuurt de gebruiker naar een overzicht van vakanties
        //
        //
        //Return: De actie naar login indien de gebruiker niet ingelogged is of de view met de vakanties
        //
        public async Task<ActionResult> Index()
        {
            if(Parse.ParseUser.CurrentUser != null)
            { 
                var vakantiesTask = vakantieRepository.FindAll();
                IEnumerable<Vakantie> vakanties = await vakantiesTask;
                return View(vakanties);
            }
            else
            {
                return RedirectToAction("Login", "Account", null);
            }
        }
        //
        //Naam: Create
        //
        //Werking: Stuurt de gebruiker naar een view om nieuwe vakantie aan te maken
        //
        //
        //Return: De view om nieuwe vakantie toe te voegen
        //
        public ActionResult Create()
        {
            return View(new Vakantie());
        }

        //
        //Naam: Create
        //
        //Werking: Maakt de vakantie aan en voegt deze toe aan de database
        //
        //Parameters:
        // - De vakantie om toe te voegen
        //
        //Return: de view indien fouten, stuurt de gebruiker door naar index
        //
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
        //
        //Naam: Edit
        //
        //Werking: geeft een view met de vakantie om aan te passen
        //
        //Parameters:
        // - Het id van de aan te passen vakantie
        //
        //Return: de view met de vakantie om aan te passen
        //
        public async Task<ActionResult> Edit(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View(vakantie);
        }

        //
        //Naam: Edit
        //
        //Werking: Past de vakantie aan in de database
        //
        //Parameters:
        // - De aangepaste vakantie
        //
        //Return: Stuurt de gebruiker terug naar de index
        //
        [HttpPost]
        public async Task<ActionResult> Edit(Vakantie v)
        {
            if (ModelState.IsValid)
            {
                await vakantieRepository.Update(v);
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
        // - id van de te verwijderen vakantie
        //
        //Return: de view om delete te bevestigen
        //
        public async Task<ActionResult> Delete(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View(vakantie);
        }
        //Naam: Delete
        //
        //Werking: Verwijdert de vakantie uit de database
        //
        //Parameters:
        // - id van de te verwijderen vakantie
        //
        //Return: de gebruiker wordt naar de index teruggestuurd
        //
        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            await vakantieRepository.Delete(vakantie);
            return RedirectToAction("Index");
        }
        //Naam: Details
        //
        //Werking: Stuurt de gebruiker naar de detailpagina van een vakantie
        //
        //Parameters:
        // - id van de te bekijken vakantie
        //
        //Return: De detailview
        //    
        public async Task<ActionResult> Details(string id)
        {
            var vakantieTask = vakantieRepository.FindBy(id);
            Vakantie vakantie = await vakantieTask;
            return View("Details", vakantie);
        }

    }
}
