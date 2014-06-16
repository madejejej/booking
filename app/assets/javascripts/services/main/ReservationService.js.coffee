@services.factory("ReservationService", ($resource) ->
  factory = {}


  factory.CRUD = (movieId,showId) ->
    return $resource("/api/movies/:movieId/shows/:showId/reservations", {},
      create:
        method: 'POST'
        params:
          showId : '@showId'
          movieId: '@movieId'
    )
  factory.getReservations = (movieId, showId, successFunction, failFunction) ->
    seats = $resource("/api/movies/#{movieId}/shows/#{showId}/reservations", {},
      query:
        method: "GET"
        isArray: true
        params:
          showId : '@showId'
          movieId: '@movieId'
    ).query(
      (response) ->
        successFunction(response) unless undefined is successFunction
    ,
      (response) ->
        failFunction(response) unless undefined is failFunction
    )
    seats
  factory
)
