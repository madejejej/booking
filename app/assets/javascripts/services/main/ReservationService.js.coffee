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
  factory
)
