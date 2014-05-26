@services.factory("SeatService", ($resource) ->

  factory = {}

  factory.getSeats = (cinemaId, screenId, successFunction, failFunction) ->
    seats = $resource("/api/cinemas/#{cinemaId}/screens/#{screenId}/seats", {},
      query:
        method: "GET"
        isArray: true
    ).query(
      successFunction(response) unless undefined is successFunction
    ,
      failFunction(response) unless undefined is failFunction
    )
    seats

  factory.createSeats= (cinemaId, screenId, seats, layout, successFunction, failFunction) ->
    $resource("/api/cinemas/#{cinemaId}/screens/#{screenId}/seats", {},
      create:
        method: 'POST'
        params:
          cinema_id: cinemaId
          screen_id: screenId
    ).create(
      seats: seats
      layout: layout
      (response) ->
        successFunction(response) unless undefined is successFunction
      ,
      (response) ->
        failFunction(response) unless undefined is failFunction
    )

  factory
)
