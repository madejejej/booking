@controllers.controller('ShowsListingController',['$scope', '$routeParams', 'MovieService',  ($scope, $routeParams, MovieService) ->

  $scope.shows = MovieService.queryShows($routeParams.movie_id)

])
