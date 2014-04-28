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
    ).query()

  factory.getCinema = (cinemaId) ->
    return $resource("/api/cinemas/#{cinemaId}", {},
      query:
        method: "GET"
    ).query()

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
