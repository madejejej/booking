@controllers.controller( 'MoviesListingController',['$scope','$location', 'MovieService',  ($scope, $location, MovieService) ->

  $scope.movies = MovieService.query()
  $scope.viewShows = (movie) ->
    $location.path("/movies/#{movie.id}/shows")

  $scope.showDetails = (movie) ->
    $location.path("/movies/#{movie.id}")

  $scope.addNewShow = (movie) ->
    $location.path("movies/#{movie.id}/shows/new")


])
