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

  factory.getByScreenAndDateRange = (screen_id, date_start, date_end) ->
    return $resource("/api/shows/screen/#{screen_id}", {},
      getByCinemaAndDateRange:
        method: 'GET'
        params:
          date_start: '@date_start'
          date_end: '@date_end'
        isArray: true
    )
  factory
)
