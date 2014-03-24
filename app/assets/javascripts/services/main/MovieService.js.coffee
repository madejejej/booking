#= require_tree ./

@services.factory("MovieService", ($resource) ->
  $resource "/api/movies", {},
    query:
      method: "GET"
      isArray: true
)