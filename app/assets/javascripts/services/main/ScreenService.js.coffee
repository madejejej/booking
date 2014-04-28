@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId) ->
    shows = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query()
    shows

  factory.createScreen= (cinemaId, screen, successFunction, failureFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens", {},
      create:
        method: 'POST'
        params:
          cinema_id: cinemaId
    ).create(
      screen,
      successFunction,
      failureFunction
    )

  factory.removeScreen = (cinemaId, screen, successFunction, failureFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      delete:
        method: 'DELETE'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).delete(
      successFunction,
      failureFunction
    )
  factory
)
