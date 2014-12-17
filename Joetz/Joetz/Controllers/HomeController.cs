using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//De homepage van de website
namespace Joetz.Controllers
{
    public class HomeController : Controller
    {   //
        //Naam: Index
        //
        //Werking: geeft de homepagina weer
        //
        //
        //Return: De view van de homepage
        //
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your app description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}
