@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId) ->
    shows = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query()
    shows

  factory.CRUD = (cinemaId) ->
    return $resource("/api/cinemas/#{cinemaId}/screens", {},
      create:
        method: 'POST'
        params:
          cinema_id: cinemaId
    )

  factory
)
