using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    [Route("/cinema-halls")]
    public class CinemaHallController: ControllerBase {

        private readonly CinemaHallService _service;

        public CinemaHallController(CinemaHallService service) {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<CinemaHall> GetAllCinemaHalls() {
            return _service.GetAllCinemaHalls();
        }
    }
}