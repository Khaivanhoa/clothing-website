using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DoAnCoSoNganh.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Test()
        {
            
            return View();
        }
        public ActionResult PartialTopbar()
        {
            return PartialView("_PartialTopbar");
        }
        public ActionResult PartialNav()
        {
            return PartialView("_PartialNav");
        }
        public ActionResult PartialFeatured()
        {
            return PartialView("_PartialFeatured");
        }
        public ActionResult PartialCategories()
        {
            return PartialView("_PartialCategories");
        }
        public ActionResult PartialOffer()
        {
            return PartialView("_PartialOffer");
        }
        public ActionResult PartialProducts()
        {
            return PartialView("_PartialProducts");
        }
        public ActionResult PartialSubscribe()
        {
            return PartialView("_PartialSubscribe");
        }
        public ActionResult PartialProducts2()
        {
            return PartialView("_PartialProducts2");
        }
        public ActionResult PartialVendor()
        {
            return PartialView("_PartialVendor");
        }
        public ActionResult PartialFooter()
        {
            return PartialView("_PartialFooter");
        }
    }
}