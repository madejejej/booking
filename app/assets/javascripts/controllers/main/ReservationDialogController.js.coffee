@controllers.controller('ReservationDialogController',
  [ '$scope','$modalInstance', 'movieId', 'showId', 'ShowService', 'TicketTypeService', ($scope, $modalInstance, movieId, showId, ShowService, TicketTypeService) ->

    $scope.reservation =
      booker: '',
      user_id : undefined


    $scope.ticketTypes = TicketTypeService.getTicketTypes(movieId, showId, (success) ->
      $scope.tickets = success
    ,(error)->
      $modalInstance.close(error)
    )

    $scope.validReservationForm = () ->
      if $scope.reservation.booker is undefined then return false
      return $scope.reservation.booker.length > 0 && !$scope.notPositiveNumberOfTickets()

    $scope.makeReservation = () ->
      reservation = $scope.reservation
      reservation.tickets = {}

      angular.forEach($scope.tickets, (ticket) ->
        reservation.tickets[ticket.id] = numberValueOrZero(ticket.count)
      )
      ShowService.CRUD(movieId,showId).create
        movieId: movieId
        showId: showId
        reservation

    $scope.notPositiveNumberOfTickets = () ->
      allTicketsCount = 0
      angular.forEach($scope.tickets, (ticket) ->
        allTicketsCount += numberValueOrZero(ticket.count)
      )
      allTicketsCount <= 0

    numberValueOrZero = (value) ->
      if angular.isNumber(value) then value else 0
]);