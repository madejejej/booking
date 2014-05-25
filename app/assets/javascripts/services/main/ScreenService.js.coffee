@services.factory("ScreenService", ($resource) ->

  factory = {}


  factory.getCinemaScreens = (cinemaId, successFunction, failFunction) ->
    screens = $resource("/api/cinemas/#{cinemaId}/screens", {},
      query:
        method: "GET"
        isArray: true
    ).query(
      successFunction(response) unless undefined is successFunction
    ,
      failFunction(response) unless undefined is failFunction
    )
    screens

  factory.createScreen= (cinemaId, screen, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens", {},
      create:
        method: 'POST'
        params:
          cinema_id: cinemaId
    ).create(
      screen,
      successFunction(response) unless undefined is successFunction
    ,
      failFunction(response) unless undefined is failFunction
    )

  factory.editScreen = (cinemaId, screen, successFunction, faileFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      update:
        method: 'PUT'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).update(
      screen
      successFunction(response) unless undefined is successFunction
    ,
      failFunction(response)  unless undefined is failFunction
    )

  factory.removeScreen = (cinemaId, screen, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screen.id}", {},
      delete:
        method: 'DELETE'
        params:
          cinema_id: cinemaId
          screen_id: screen.id
    ).delete(
      successFunction(response)  unless undefined is successFunction
    ,
      failFunction(response)  unless undefined is failFunction
  )
  factory
)
