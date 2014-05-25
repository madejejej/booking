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
  factory
)
