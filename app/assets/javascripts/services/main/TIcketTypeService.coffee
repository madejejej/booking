@services.factory('TicketTypeService', [ '$resource',($resource) ->
  factory = {}

  factory.getTicketTypes = (movieId, showId, successResult, errorResult) ->
    $resource("/api/movies/#{movieId}/shows/#{showId}/ticket_type", {},).query((success)->
      successResult(success)
    ,(error)->errorResult(error))

  factory
])