using Domain.Models.ViewModel;
using LoginAppMVC.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace LoginAppMVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [Route("{route?}")]
        public IActionResult Index(string route)
        {
            RoutingHelper routingHelper = new RoutingHelper();
            routingHelper.RouteName= route;
            routingHelper.IsShow = true;
            return View(routingHelper);

        }
        public IActionResult Blazor()
        {
            ViewData["Title"] = "Blazor Page";
            return View();
        }
        public IActionResult LoadBlazorComponent(string route)
        {
            RoutingHelper routingHelper = new RoutingHelper
            {
                RouteName = route,
                IsShow = true
            };

            // Return the partial view with the model
            return PartialView("_BlazorPagePartial", routingHelper);
        }
        public IActionResult LoadMvcComponent(string route)
        {
            RoutingHelper routingHelper = new RoutingHelper
            {
                RouteName = route,
                IsShow = true
            };

            // Return the partial view with the model
            return PartialView("_MvcPagePartial");
        }
        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
