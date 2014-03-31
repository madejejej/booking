@controllers.controller('ShowsListingController',
  ['$scope', '$routeParams', 'ShowService', ($scope, $routeParams, ShowService) ->
    $scope.shows = ShowService.queryShows($routeParams.movie_id)

  ])
