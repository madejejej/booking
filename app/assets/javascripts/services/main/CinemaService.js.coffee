@services.factory("CinemaService", ($resource) ->
  factory = {}

  factory.CRUD = (name, location, phone) ->
    return $resource("/api/cinemas", {},
      create:
        method: 'POST'
        params:
          name : '@name'
          location: '@location'
          phone: '@phone'
    )

  factory.updateCinema = (cinema) ->
    return $resource("/api/cinemas/#{cinema.id}", {},
      query:
        method: "PATCH"
        params:
          name: cinema.name
          location: cinema.location
          phone: cinema.phone
    ).query( () ->
      window.location = "/cinemas/"
    )

  factory.getCinema = (cinemaId, successFunction, errorFunction) ->
    return $resource("/api/cinemas/#{cinemaId}", {},
      query:
        method: "GET"
    ).query((success) ->
      successFunction(success) unless  undefined is successFunction
    ,(error) ->
      errorFunction(error) unless  undefined is errorFunction
    )

  factory.deleteCinema = (cinemaId) ->
    $resource("/api/cinemas/#{cinemaId}", {},
      query:
        method: "DELETE"
    ).query()

  factory.list = () ->
    cinemas = $resource("/api/cinemas/", {},
      query:
        method: "GET"
        isArray: true
    ).query()
    cinemas





  factory
)
