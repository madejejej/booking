@controllers.controller('CinemaUpdateController',
  ['$scope', '$routeParams', 'CinemaService', ($scope, $routeParams, CinemaService) ->
    $scope.cinema = CinemaService.getCinema($routeParams.cinema_id)
    $scope.cinema.id = $routeParams.cinema_id

    $scope.updateCinema = () ->
      CinemaService.updateCinema($scope.cinema)
  ])

