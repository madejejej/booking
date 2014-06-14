@services.factory("ShowService", ($resource) ->
  factory = {}

  factory.queryShows = (movieId) ->
    shows = $resource("/api/movies/#{movieId}/shows", {},
      query:
        method: "GET"
        isArray: true
    ).query(->
      angular.forEach shows, (show) ->
        show.date = new Date(show.date).toString("d-MMM-yyyy HH:mm")
        return
    )
    shows

  factory.CRUD = (movieId) ->
    return $resource("/api/movies/:movieId/shows", {},
      create:
        method: 'POST'
        params:
          movieId: '@movieId'
    )

  factory.getByScreenAndDateRange = (screen_id, dateStart, dateEnd) ->
    # TODO return shows from service
    console.log('GOT iT');
    console.log(screen_id);
    console.log(dateStart);
    console.log(dateEnd);
    movies = [
      {
        title: "Matrix"
        date: new Date()
      }
      {
        title: "Matrix 2"
        date: new Date
      }
    ]
    return movies

  factory
)
