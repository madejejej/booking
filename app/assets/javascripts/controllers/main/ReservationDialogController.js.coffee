@controllers.controller('ReservationDialogController',
  [ '$scope', 'showId', 'ShowService', ($scope, showId, ShowService) ->
    $scope.msg = 'hejka z kontolera' + showId

    $scope.reservation =
      booker: '',
      numberOfSeats: 1,
      user_id : undefined


    $scope.validReservationForm = () ->
      return $scope.reservation.booker.length > 0 && $scope.reservation.numberOfSeats > 0

    $scope.makeReservation = () ->
      ShowService.CRUD().create
        showId: showId
        $scope.reservation

]);