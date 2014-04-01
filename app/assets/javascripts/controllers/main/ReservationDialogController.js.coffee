@controllers.controller('ReservationDialogController',
  [ '$scope', 'showId', 'ShowService', ($scope, showId, ShowService) ->
    $scope.msg = 'hejka z kontolera' + showId

  $scope.reservation =
    bookerName: '',
    numberOfSeats: 1

  $scope.validReservationForm = () ->
    return $scope.reservation.bookerName.length > 0 && $scope.reservation.numberOfSeats > 0

  $scope.makeReservation = () ->
    ShowService.CRUD().create
      showId: showId
      $scope.reservation

    console.log('fired!')

]);