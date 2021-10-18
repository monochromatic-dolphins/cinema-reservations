using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    [Route("/seances")]
    public class SeanceController: ControllerBase {
        private readonly SeanceService _service;

        public SeanceController(SeanceService service) {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<Seance> GetAllSeances() {
            return _service.GetAllSeances();
        }

        [HttpPost]
        public ActionResult<Seance> CreateSeance(Seance seance) {
            var createdSeance = _service.CreateSeance(seance);
            if (createdSeance != null) {
                return Ok(createdSeance);
            }
            return BadRequest();
        }
    }
}