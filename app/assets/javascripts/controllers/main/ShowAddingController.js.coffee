@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService', 'CinemaService',  ($scope, $location,$routeParams,ShowService, MovieService,CinemaService) ->
#  console.log($routeParams.movie_id);

  $scope.movieId = parseInt($routeParams.movie_id)

  $scope.selected =
    movie: null
    cinema: null
    screen: null

  $scope.serverData =
    movies: []
    cinemas: []

  MovieService.query( (successResult) ->
    $scope.serverData.movies = successResult;
    angular.forEach(successResult, (movie) ->
      if movie.id is $scope.movieId
        $scope.selected.movie = movie
        return
    )
  )

  CinemaService.list ((successResult) ->
    $scope.serverData.cinemas = successResult
    $scope.selected.cinema = $scope.serverData.cinemas[0]
  ), (errorResult) ->
    console.log(errorResult);

])
