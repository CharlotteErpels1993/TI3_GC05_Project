using Joetz.Models.DAL;
using Joetz.Models.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Joetz.Controllers
{
    public class AdminController : Controller
    {
       private IAdminRepository adminRepository;

        public VormingController()
        {
            this.adminRepository = new AdminRepository();
        }

        public VormingController(IAdminRepository adminRepository)
        {
            this.adminRepository = adminRepository;
        }

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

        public ActionResult Create()
        {
            return View(new Vorming());
        }

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

        public async Task<ActionResult> Edit(string id)
        {
            var vormingTask = vormingRepository.FindBy(id);
            Vorming vorming = await vormingTask;
            return View(vorming);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(Vorming v)
        {
            await vormingRepository.Update(v);
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
            await vormingRepository.Delete(vorming);
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
