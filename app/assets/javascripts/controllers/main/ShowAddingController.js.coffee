@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService', 'CinemaService','ScreenService','ShowTypeService',  ($scope, $location,$routeParams,ShowService, MovieService,CinemaService, ScreenService, ShowTypeService) ->
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
    showType: null;


  $scope.serverData =
    movies: []
    cinemas: []
    screens: []
    showTypes: []

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


  $scope.cinemaChanged = (cinema) ->
    ScreenService.getCinemaScreens cinema.id, ((successResult) ->
      $scope.serverData.screens = successResult
    ), (errorResult) ->
      console.log errorResult

    ShowTypeService.query
      cinema_id: cinema.id
    , ((successResult) ->
      console.log successResult
      $scope.serverData.showTypes = successResult
    ), (error) ->
      console.log error


  $scope.createShow = () ->
    console.log($scope.selected)

    show =
      movie_id: $scope.selected.movie.id
      screen_id: $scope.selected.screen.id
      show_type_id: $scope.selected.showType.id
      datetime: new Date(); # TODO

    ShowService.CRUD(show.movie_id).create
      movieId: show.movie_id
      show: show
      (success) ->
        console.log(success);
      (error) ->
        console.log(error);

  $scope.validShowForm = () ->
    $scope.selected.cinema != null && $scope.selected.showType!= null && $scope.selected.movie != null && $scope.selected.screen != null && $scope.selected.date.day != null && $scope.selected.date.time != null


  $scope.collapseScreenAndShowType = () ->
    $scope.selected.cinema == null


])
