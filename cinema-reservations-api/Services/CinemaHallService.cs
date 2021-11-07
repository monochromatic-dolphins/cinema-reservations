using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Repository;

namespace cinema_reservations_api.Services {
    public class CinemaHallService {

        private readonly CinemaHallRepository _repository;

        public CinemaHallService(CinemaHallRepository repository) {
            _repository = repository;
        }
        public IEnumerable<CinemaHall> GetAllCinemaHalls() {
            return _repository.GetAllCinemaHalls();
        }

        public CinemaHall CreateCinemaHall(CinemaHall cinemaHall) {
            var createdCinemaHall = _repository.CreateCinemaHall(cinemaHall);
            return createdCinemaHall;
        }
    }
}