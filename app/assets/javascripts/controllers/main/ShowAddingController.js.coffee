@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService', 'CinemaService','ScreenService',  ($scope, $location,$routeParams,ShowService, MovieService,CinemaService, ScreenService) ->
#  console.log($routeParams.movie_id);

  $scope.movieId = parseInt($routeParams.movie_id)

  $scope.minDate = () ->
    return new Date()

  $scope.selected =
    movie: null
    cinema: null
    screen: null
    date:
      day: new Date()
      time: new Date()


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
    ), (errorResult) ->
      console.log(errorResult);


  $scope.createShow = () ->
    console.log($scope.selected)

    show =
      movie_id: $scope.selected.movie.id
      screen_id: $scope.selected.screen.id
#      show_type_id: $scope.selected.show_type.id
      show_type_id: 1
      datetime: new Date();

    ShowService.CRUD(show.movie_id).create
      movieId: show.movie_id
      show: show
      (success) ->
        console.log(success);
      (error) ->
        console.log(error);

  $scope.validShowForm = () ->
    $scope.selected.cinema != null && $scope.selected.movie != null && $scope.selected.screen != null && $scope.selected.date.day != null && $scope.selected.date.time != null


])
