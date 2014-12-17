using Joetz.Models.DAL;
using Joetz.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
//Geeft de gebruiker de mogelijkheid de administrators te beheren
namespace Joetz.Controllers
{
    public class AdminController : Controller
    {
        //Repository
       private IAdminRepository adminRepository;

        public AdminController()
        {
            this.adminRepository = new AdminRepository();
        }

        public AdminController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }
        //
        //Naam: Index
        //
        //Werking: Stuurt de gebruiker naar een overzicht van administrators
        //
        //
        //Return: De actie naar login indien de gebruiker niet ingelogged is of de view met de administrators
        //
        public async Task<ActionResult> Index()
        {
            if(Parse.ParseUser.CurrentUser != null)
            {
                var adminTask = adminRepository.FindAll();
                IEnumerable<Admin> admin = await adminTask;
                return View(admin);
            }
            else
            {
                return RedirectToAction("Login", "Account", null);
            }
        }
        //
        //Naam: Create
        //
        //Werking: Stuurt de gebruiker naar een view om een nieuwe administrator aan te maken
        //
        //
        //Return: De view met een nieuwe administrator om op te vullen
        //
        public ActionResult Create()
        {
            return View(new Admin());
        }
        //
        //Naam: Create
        //
        //Werking: Maakt de administrator aan en voegt deze toe aan de database
        //
        //Parameters:
        // - De administrator die toegevoegd moet worden
        //
        //Return: de view met de administrator indien fouten, stuurt de gebruiker door naar login om opnieuw in te loggen na toevoegen administrator
        //
        [HttpPost]
        public async Task<ActionResult> Create(Admin admin)
        {
            if (ModelState.IsValid)
            {
                await adminRepository.Add(admin);
                TempData["Info"] = "Administrator " + admin.Email + " is toegevoegd";
                return RedirectToAction("Login", "Account", null);
            }
            return View(admin);
        }

        //
        //Naam: Delete
        //
        //Werking: Stuurt de gebruiker door naar de pagina om delete te bevestigen
        //
        //Parameters:
        // - id van de te verwijderen user
        //
        //Return: de view om delete te bevestigen
        //
        public async Task<ActionResult> Delete(string id)
        {
            var adminTask = adminRepository.FindBy(id);
            Admin admin = await adminTask;
            return View(admin);
        }
        //Naam: Delete
        //
        //Werking: Verwijdert de gebruiker uit de database, kan enkel door gebruiker zelf gedaan worden
        //
        //Parameters:
        // - id van de te verwijderen gebruiker
        //
        //Return: de gebruiker wordt naar de index teruggestuurd
        //
        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var adminTask = adminRepository.FindBy(id);
            Admin admin = await adminTask;
            await adminRepository.Delete(admin);
            Parse.ParseUser.LogOut();
            return RedirectToAction("Index");
        }

       
    }
}
