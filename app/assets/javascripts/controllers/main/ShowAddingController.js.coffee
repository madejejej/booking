@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService', 'CinemaService','ScreenService',  ($scope, $location,$routeParams,ShowService, MovieService,CinemaService, ScreenService) ->
#  console.log($routeParams.movie_id);

  $scope.movieId = parseInt($routeParams.movie_id)



  $scope.selected =
    movie: null
    cinema: null
    screen: null

  $scope.serverData =
    movies: []
    cinemas: []
    screens: []

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
  ), (errorResult) ->
    console.log(errorResult);


  $scope.getScreens = (cinema) ->
    ScreenService.getCinemaScreens cinema.id, ((successResult) ->
      $scope.serverData.screens = successResult;
      console.log(successResult);
    ), (errorResult) ->
      console.log(errorResult);

    console.log(cinema);

])
