using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace cinema_reservations_api.Model {
    public class Seance { 
        public int SeanceId { get; set; }
        public DateTime StartTime { get; set; }

        public Movie Movie { get; set; }
        
        public CinemaHall CinemaHall { get; set; }

        public override string ToString() {
            return $"{SeanceId} {StartTime} {Movie} {CinemaHall}";
        }
    }
}