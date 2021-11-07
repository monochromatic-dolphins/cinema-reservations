using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Repository;

namespace cinema_reservations_api.Services {
    public class ReservationService {

        private readonly ReservationRepository _repository;

        public ReservationService(ReservationRepository repository) {
            _repository = repository;
        }
        public IEnumerable<Reservation> GetAllReservations() {
            return _repository.GetAllReservations();
        }

        public Reservation CreateReservation(Reservation reservation) {
            var createdReservation = _repository.CreateReservation(reservation);
            return createdReservation;
        }

        public Reservation ConfirmReservation(int id) {
            var confirmedReservation = _repository.ConfirmReservation(id);
            return confirmedReservation;
        }
    }
}