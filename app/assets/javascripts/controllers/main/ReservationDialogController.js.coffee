@controllers.controller('ReservationDialogController',
  [ '$scope','$modalInstance', 'movieId', 'showId', 'ShowService', 'TicketTypeService', ($scope, $modalInstance, movieId, showId, ShowService, TicketTypeService) ->

    $scope.reservation =
      booker: '',
      user_id : undefined


    $scope.alert = {}

    $scope.ticketTypes = TicketTypeService.getTicketTypes(movieId, showId, (success) ->
      $scope.tickets = success
    ,(error)->
      $modalInstance.close({message:error, type: 'error'})
    )

    $scope.validReservationForm = () ->
      if $scope.reservation.booker is undefined then return false
      return $scope.reservation.booker.length > 0 && !$scope.notPositiveNumberOfTickets()

    $scope.chooseSeats = () ->
      reservation = $scope.reservation
      reservation.tickets = {}

      angular.forEach($scope.tickets, (ticket) ->
        reservation.tickets[ticket.id] = numberValueOrZero(ticket.count)
      )
      $modalInstance.close({reservationData: reservation, type: 'success'})

      ###ShowService.CRUD(movieId,showId).create
        movieId: movieId
        showId: showId
        reservation
        (success) ->
          $modalInstance.close({message:success.message, type: 'success'})
        (error) ->
          $scope.alert = ({message: error.data.message, type: 'danger'})###

    $scope.notPositiveNumberOfTickets = () ->
      allTicketsCount = 0
      angular.forEach($scope.tickets, (ticket) ->
        allTicketsCount += numberValueOrZero(ticket.count)
      )
      allTicketsCount <= 0

    numberValueOrZero = (value) ->
      if angular.isNumber(value) then value else 0

    $scope.showAlert = () ->
      $scope.alert.message != undefined and $scope.alert.message != ''

    $scope.closeAlert = () ->
      $scope.alert = {}

    $scope.totalPrice = () ->
      price = 0
      angular.forEach($scope.tickets, (ticket) ->
        price += ticket.price_in_eurocents*numberValueOrZero(ticket.count)
      )
      price
]);