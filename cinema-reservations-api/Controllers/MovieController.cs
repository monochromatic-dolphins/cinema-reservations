using System.Collections.Generic;
using cinema_reservations_api.Model;
using cinema_reservations_api.Services;
using Microsoft.AspNetCore.Mvc;

namespace cinema_reservations_api.Controllers {
    [ApiController]
    [Route("/movies")]
    public class MovieController : ControllerBase {
        private readonly MovieService _service;

        public MovieController(MovieService service) {
            _service = service;
        }

        [HttpGet]
        public IEnumerable<Movie> GetAllMovies() {
            return _service.GetAllMovies();
        }

        [HttpPost]
        public ActionResult<Movie> CreateMovie(Movie movie) {
            var createdMovie = _service.CreateMovie(movie);
            if (createdMovie != null)
                return Ok(createdMovie);
            return BadRequest();
        }
    }
}