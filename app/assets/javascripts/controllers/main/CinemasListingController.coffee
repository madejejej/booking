@controllers.controller( 'CinemasListingController',['$scope', '$location', 'CinemaService',  ($scope, $location, CinemaService) ->
  $scope.cinemas = CinemaService.list()
  $scope.view = (cinema) ->
    $location.path("/cinemas/#{cinema.id}")

  $scope.deleteCinema = (cinema) ->
    CinemaService.deleteCinema(cinema.id)
    window.location.reload(false)
])