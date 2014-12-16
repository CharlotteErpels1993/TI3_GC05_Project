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
    public class AdminController : Controller
    {
       private IAdminRepository adminRepository;

        public AdminController()
        {
            this.adminRepository = new AdminRepository();
        }

        public AdminController(IAdminRepository adminRepository)
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
            return View(new Admin());
        }

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

       
        public async Task<ActionResult> Delete(string id)
        {
            var adminTask = adminRepository.FindBy(id);
            Admin admin = await adminTask;
            return View(admin);
        }

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
