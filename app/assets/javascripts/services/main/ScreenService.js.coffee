@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId, successFunction, failFunction) ->
    screens = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query(
      (response) ->
        successFunction(response) unless undefined is successFunction
      ,
      (response) ->
        failFunction(response) unless undefined is failFunction
    )
    screens

  factory.getScreen = (cinemaId, screenId, successFunction, failFunction) ->
    screen = $resource("/api/cinemas/#{cinemaId}/screens/#{screenId}", {},
      query:
        method: "GET"
    ).query(
      (response) ->
        successFunction(response) unless undefined is successFunction
      (response) ->
        failFunction(response) unless undefined is failFunction
    )
    screen

  factory.createScreen= (cinemaId, screen, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens", {},
      create:
        method: 'POST'
        params:
          cinema_id: cinemaId
    ).create(
      screen,
      (response) ->
        successFunction(response) unless undefined is successFunction
      ,
      (response) ->
        failFunction(response) unless undefined is failFunction
    )

  factory.editScreen = (cinemaId, screen, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      update:
        method: 'PUT'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).update(
      screen
      (response) ->
        successFunction(response) unless undefined is successFunction
      ,
      (response) ->
        failFunction(response) unless undefined is failFunction
    )

  factory.removeScreen = (cinemaId, screen, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      delete:
        method: 'DELETE'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).delete(
      (response) ->
        successFunction(response) unless undefined is successFunction
      ,
      (response) ->
        failFunction(response) unless undefined is failFunction
  )
  factory
)
