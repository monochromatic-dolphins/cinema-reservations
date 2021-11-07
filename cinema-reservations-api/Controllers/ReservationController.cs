using System;
using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    [Route("/reservations")]
    public class ReservationController: ControllerBase {

        private readonly ReservationService _service;

        public ReservationController(ReservationService service) {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<Reservation> GetAllReservations() {
            return _service.GetAllReservations();
        }

        [HttpPost]
        public ActionResult<Reservation> CreateReservation(Reservation reservation) {
            var createdReservation = _service.CreateReservation(reservation);
            if (createdReservation != null) {
                return Ok(createdReservation);
            }
            return BadRequest();
        }

        [HttpDelete]
        [Route("{id:int}")]
        public ActionResult<string> DeleteReservation(int id) {
            var isSuccess = _service.DeleteReservation(id);
            if (isSuccess) {
                return Ok();
            }
            return BadRequest("This reservation is not temporary!");
        }

        [HttpPost("confirm/{id:int}")]
        public ActionResult<Reservation> ConfirmReservation(int id) {
            var confirmedReservation = _service.ConfirmReservation(id);
            if (confirmedReservation != null) {
                return Ok(confirmedReservation);
            }
            return BadRequest();
        }

    }
}