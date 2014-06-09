@services.factory("MovieService", ($resource) ->

  factory = {}

  factory.query = (successFunction, failFunction) ->
    movies = $resource("/api/movies", {},
      query:
        method: "GET"
        isArray: true
    ).query((successResult)->
      angular.forEach movies, (movie) ->
        time = Date.today().addHours(Math.floor(movie.duration/60)).addMinutes(movie.duration%60)
        movie.duration = time.toString("HH:mm")
        return
      successFunction(movies) unless undefined is successFunction
      return
    ,
      (errorResult) ->
        failFunction(errorResult) unless undefined is failFunction
        return
      )
    movies

  factory.create = (movie) ->
    return $resource("/api/movies/", {},
      query:
        method: "POST"
        params:
          title: movie.title
          description: movie.description
          director: movie.director
    ).query(
      (successResult) ->
        movie = successResult
        window.location = "/movies/#{movie.id}"
        $scope.apply()
    )

  factory
)
