using System.ComponentModel.DataAnnotations;

namespace cinema_reservations_api.Model {
    public class CinemaHall {
        public int CinemaHallId { get; set; }
        public int Seats { get; set; }
        public int Rows { get; set; }

        public override string ToString() {
            return $"{CinemaHallId} {Seats} {Rows}";
        }
    }
}