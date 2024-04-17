using Microsoft.AspNetCore.Mvc;
using Pms.Data.DbContex;
using Pms.Data.Repository.Inventory;
using System.Data;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Pms.Data.Controller.Inventory
{
    [Route("api/[controller]")]
    [ApiController]
    public class UnitsController : ControllerBase
    {
        private readonly UnitService _unitService;
        public UnitsController(DbConnection db)
        {
            _unitService = new UnitService(db);
        }
        // GET: api/<UnitsController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<UnitsController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<UnitsController>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<UnitsController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<UnitsController>/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(long id)
        {
            {
                bool isDelete = false;
                try
                {
                    isDelete = await _unitService.Delete(id);
                    return Ok(isDelete);


                }
                catch (Exception ex)
                {
                    return Ok(isDelete);
                }
            }

        }
    }
}
