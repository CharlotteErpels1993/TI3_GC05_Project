using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using Joetz.Models.DAL;
using Joetz.Models.Domain;

namespace Joetz.Controllers
{
    public class MonitorController : Controller
    {
        private IMonitorRepository monitorRepository;

        public MonitorController()
        {
            this.monitorRepository = new MonitorRepository();
        }

        public MonitorController(IMonitorRepository monitorRepository)
        {
            this.monitorRepository = monitorRepository;
        }

        public async Task<ActionResult> Index()
        {
            var monitorenTask = monitorRepository.FindAll();
            IEnumerable<Monitor> monitoren = await monitorenTask;
            return View(monitoren);
        }

        //public ActionResult Create()
        //{
        //    return View(new Monitor());
        //}

        //[HttpPost]
        //public ActionResult Create(Monitor monitor)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        monitorRepository.Add(monitor);
        //        TempData["Info"] = "Monitor " + monitor.Voornaam + " " + monitor.Naam + " is toegevoegd";
        //        return RedirectToAction("Index");    
        //    }
        //    return View(monitor);
        //}

        public async Task<ActionResult> Edit(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            return View(monitor);
        }

        [HttpPost]
        public async Task<ActionResult> Edit(string id, FormCollection formValues)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            UpdateModel(monitor, formValues.ToValueProvider());
            monitorRepository.Update(monitor);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Delete(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            return View(monitor);
        }

        [HttpPost, ActionName("Delete")]
        public async Task<ActionResult> DeleteConfirmed(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            monitorRepository.Delete(monitor);
            return RedirectToAction("Index");
        }

    }
}
