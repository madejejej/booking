@services.factory("ShowService", ($resource) ->

  factory = {}

  factory.query = (movieId) ->
    shows = $resource("/api/movies/#{movieId}/shows", {},
      query:
        method: "GET"
        isArray: true
    )
    shows
  factory
)