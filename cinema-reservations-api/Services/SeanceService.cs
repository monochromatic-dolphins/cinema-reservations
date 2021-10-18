using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Repository;

namespace cinema_reservations_api.Services {
    public class SeanceService {

        private readonly SeanceRepository _repository;

        public SeanceService(SeanceRepository repository) {
            _repository = repository;
        }

        public IEnumerable<Seance> GetAllSeances() {
            return _repository.GetAllSeances();
        }

        public Seance CreateSeance(Seance seance) {
            var createdSeance = _repository.CreateSeance(seance);
            return createdSeance;
        }
    }
}