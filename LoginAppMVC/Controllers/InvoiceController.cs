using Domain.Models.ViewModel;
using Microsoft.AspNetCore.Mvc;

namespace LoginAppMVC.Controllers
{
    public class InvoiceController : Controller
    {
        public IActionResult Create()
        {
            return PartialView("Create");
        }
    }
}
