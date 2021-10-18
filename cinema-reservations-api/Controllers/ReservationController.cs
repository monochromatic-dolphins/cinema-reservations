using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    [Route("/reservations")]
    public class ReservationController {

        private readonly ReservationService _service;

        public ReservationController(ReservationService service) {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<Reservation> GetAllReservations() {
            return _service.GetAllReservations();
        }
    }
}