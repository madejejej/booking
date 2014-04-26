@services.factory("CinemaService", ($resource) ->
  factory = {}

  factory.createCinema = (name, location, phone) ->
    return $resource("/api/cinemas/create", {},
      create:
        method: 'POST'
        params:
          name : '@name'
          location: '@location'
          phone: '@phone'
    )
  factory
)
