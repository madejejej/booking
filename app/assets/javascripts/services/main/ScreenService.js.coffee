@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId) ->
    shows = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query()
    shows
  factory
)
