@controllers.controller('ReservationDialogController',
  [ '$scope', 'movieId', 'showId', 'ShowService', ($scope, movieId, showId, ShowService) ->
    $scope.msg = 'hejka z kontolera' + showId

    $scope.reservation =
      booker: '',
      numberOfSeats: 1,
      user_id : undefined


    $scope.validReservationForm = () ->
      if $scope.reservation.booker is undefined then return false
      return $scope.reservation.booker.length > 0 && $scope.reservation.numberOfSeats > 0

    $scope.makeReservation = () ->
      console.log(movieId, showId)
      ShowService.CRUD(movieId,showId).create
        movieId: movieId
        showId: showId
        $scope.reservation

  ]);