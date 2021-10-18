using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Repository;

namespace cinema_reservations_api.Services {
    public class MovieService {

        private readonly MovieRepository _repository;

        public MovieService(MovieRepository repository) {
            _repository = repository;
        }

        public IEnumerable<Movie> GetAllMovies() {
            return _repository.GetAllMovies();
        }
    }
}