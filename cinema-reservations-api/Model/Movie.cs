using System.ComponentModel.DataAnnotations;

namespace cinema_reservations_api.Model {
    public class Movie {
        public int MovieId { get; set; }
        public string Title { get; set; }
        public int Duration { get; set; }

        public override string ToString() {
            return $"{MovieId} {Title} {Duration}";
        }
    }
}