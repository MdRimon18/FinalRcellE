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
