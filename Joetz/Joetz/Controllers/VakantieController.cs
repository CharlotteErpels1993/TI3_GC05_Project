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

    }
}
