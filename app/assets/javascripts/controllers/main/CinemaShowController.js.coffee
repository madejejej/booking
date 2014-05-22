@controllers.controller('CinemaShowController',
  ['$scope', '$routeParams', 'CinemaService', ($scope, $routeParams, CinemaService) ->
    $scope.cinema = CinemaService.getCinema($routeParams.cinema_id)
  ])
