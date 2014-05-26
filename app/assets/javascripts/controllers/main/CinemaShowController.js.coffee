@controllers.controller('CinemaShowController',
  ['$scope', '$routeParams', '$location', 'CinemaService', ($scope, $routeParams, $location, CinemaService) ->
    $scope.cinema = CinemaService.getCinema($routeParams.cinema_id)
    $scope.showScreens = () ->
      $location.path("/cinemas/#{$scope.cinema.id}/screens")
  ])
