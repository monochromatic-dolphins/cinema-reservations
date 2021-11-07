using System;
using System.ComponentModel.DataAnnotations;

namespace cinema_reservations_api.Model {
    public class Reservation {
        public int ReservationId { get; set; }
        public int Row { get; set; }
        public int Seat { get; set; }
        public bool IsTemporary { get; set; }
        public DateTime CreatedTime { get; set; }
        public User User { get; set; }
        public Seance Seance { get; set; }
    }
}