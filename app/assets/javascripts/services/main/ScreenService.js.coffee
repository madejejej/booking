@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId, successFunction , errorFunction ) ->
    shows = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query((success) ->
      successFunction(success) unless undefined is successFunction
    , (error) ->
      errorFunction(error) unless undefined is errorFunction
    )
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

  factory.editScreen = (cinemaId, screen, successFunction, failureFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      update:
        method: 'PUT'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).update(
      screen
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
