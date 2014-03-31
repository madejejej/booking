#= require ./services.js

@services.factory("ShowService", ($resource) ->
  factory = {}

  factory.queryShows = (movieId) ->
    shows = $resource("/api/movies/#{movieId}/shows", {},
      query:
        method: "GET"
        isArray: true
    ).query()
    shows
  factory
)