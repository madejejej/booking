@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService',  ($scope, $location,$routeParams,ShowService, MovieService) ->
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


])
