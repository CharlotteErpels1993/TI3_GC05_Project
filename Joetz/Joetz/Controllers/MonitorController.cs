using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web;
using System.IO;
using Joetz.Models.DAL;
using Joetz.Models.Domain;
using Excel;
using Parse;

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
            if(Parse.ParseUser.CurrentUser != null)
            {
                var monitorenTask = monitorRepository.FindAll();
                IEnumerable<Monitor> monitoren = await monitorenTask;
                return View(monitoren);
            }
            else
            {
                return RedirectToAction("Login", "Account", null);
            }
           
        }

        public ActionResult Create()
        {
            return View();
        }


        //onderstaande methode dient voor de fileupload
        [HttpPost]
        public async Task<ActionResult> Create(HttpPostedFileBase file)
        {
            // Zeker zijn dat gebruiker bestand heeft geselecteerd
            if (file != null && file.ContentLength > 0)
            {
                //file name ophalen
                string fileName = Path.GetFileName(file.FileName);
                if (fileName.EndsWith(".xlsx") || (fileName.EndsWith(".xls"))) //enkel gewoon Excel bestand wordt aanvaard.
                {
                    // store the file inside ~/App_Data/uploads folder
                    var path = Path.Combine(Server.MapPath("~/App_Data/uploads/"), fileName);
                    file.SaveAs(path);
                    Monitor m = new Monitor();
                    IList<Monitor> monitorern = new List<Monitor>();

                    IExcelDataReader reader = ExcelReaderFactory.CreateOpenXmlReader(file.InputStream);

                    reader.Read();

                        while(reader.Read()) //14 kolommen +-
                        {
                            ParseUser current = ParseUser.CurrentUser;

                            var user = new ParseUser()
                            {
                                Username = reader.GetString(2),
                                Password = "admin",
                                Email = reader.GetString(2)
                            };

                            user["soort"] = "monitor";

                            await user.SignUpAsync();
                            Parse.ParseUser.LogOut();
                            m.Naam = reader.GetString(0);
                            m.Voornaam = reader.GetString(1);
                            m.Email = reader.GetString(2);
                            m.Straat = reader.GetString(3);
                            m.Nummer = reader.GetInt32(4);
                            m.Bus = reader.GetString(5);
                            m.Gemeente = reader.GetString(6);
                            m.Postcode = reader.GetInt32(7);
                            m.Telefoon = reader.GetString(8);
                            m.Gsm = reader.GetString(9);
                            m.Rijksregisternummer = reader.GetString(10);
                            m.Aansluitingsnummer = reader.GetInt32(11);
                            m.CodeGerechtigde = reader.GetInt32(12);
                            m.Lidnummer = reader.GetString(13);

                            
                            await monitorRepository.Add(m);

                            
                            
                        }
                    } return RedirectToAction("Index");
                }
            return View();
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
            await monitorRepository.Delete(monitor);
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> Details(string id)
        {
            var monitorTask = monitorRepository.FindBy(id);
            Monitor monitor = await monitorTask;
            return View("Details", monitor);
        }

    }
}
