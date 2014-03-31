@services.factory("MovieService", ($resource) ->

  factory = {}

  factory.query = (successFunction, failFunction) ->
    movies = $resource("/api/movies", {},
      query:
        method: "GET"
        isArray: true
    ).query(->
      angular.forEach movies, (movie) ->
        time = Date.today().addHours(Math.floor(movie.duration/60)).addMinutes(movie.duration%60)
        movie.duration = time.toString("HH:mm")
        return

      successFunction() unless undefined is successFunction
      return
    ,
      (errorResult) ->
        failFunction() errorResult unless undefined is failFunction
        return
      )
    movies
  factory
)
