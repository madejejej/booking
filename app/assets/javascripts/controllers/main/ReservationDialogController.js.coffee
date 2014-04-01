@controllers.controller('ReservationDialogController', [ '$scope', 'showId', ($scope, showId) ->
  $scope.msg = 'hejka z kontolera' + showId

  $scope.reservation =
    bookerName: '',
    numberOfSeats: 1

  $scope.validReservationForm = () ->
    return $scope.reservation.bookerName.length > 0 && $scope.reservation.numberOfSeats > 0

  $scope.makeReservation = () ->
    console.log('fired!')

]);