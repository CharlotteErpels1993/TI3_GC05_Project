using System.Collections.Generic;
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

        public ActionResult Index()
        {
            var vakantiesTask = vakantieRepository.FindAll();
            IEnumerable<Vakantie> vakanties = vakantiesTask.Result;
            return View(vakanties);
        }

    }
}
