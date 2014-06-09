@controllers.controller( 'MoviesListingController',['$scope','$location', '$route', 'MovieService',  ($scope, $location,$route, MovieService) ->

  $scope.movies = MovieService.query()
  $scope.viewShows = (movie) ->
    $location.path("/movies/#{movie.id}/shows")

  $scope.showDetails = (movie) ->
    $location.path("/movies/#{movie.id}")

  $scope.addNewShow = (movie) ->
    $location.path("movies/#{movie.id}/shows/new")
])
