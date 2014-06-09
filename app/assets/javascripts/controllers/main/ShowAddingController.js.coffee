@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService', 'MovieService', 'CinemaService','ScreenService','ShowTypeService',  ($scope, $location,$routeParams,ShowService, MovieService,CinemaService, ScreenService, ShowTypeService) ->

  $scope.movieId = parseInt($routeParams.movie_id)

  $scope.alerts = []

  $scope.minDate = () ->
    return new Date()

  $scope.selected =
    movie: null
    cinema: null
    screen: null
    date: new Date()
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
    $scope.alerts.push({message: errorResult.data.message, type: 'danger'})


  $scope.cinemaChanged = (cinema) ->
    ScreenService.getCinemaScreens cinema.id, ((successResult) ->
      $scope.serverData.screens = successResult
    ), (errorResult) ->
      $scope.alerts.push({message: errorResult.data.message, type: 'danger'})

    ShowTypeService.query
      cinema_id: cinema.id
    , ((successResult) ->
      $scope.serverData.showTypes = successResult
    ), (error) ->
      $scope.alerts.push({message: error.data.message, type: 'danger'})


  $scope.createShow = () ->
    show =
      movie_id: $scope.selected.movie.id
      screen_id: $scope.selected.screen.id
      show_type_id: $scope.selected.showType.id
      cinema_id: $scope.selected.cinema.id
      datetime: $scope.selected.date.set(
        second: 0
        millisecond: 0
      )

    ShowService.CRUD(show.movie_id).create
      movieId: show.movie_id
      show: show
      (success) ->
        $scope.alerts.push({message: success.message, type: 'success'})
      (error) ->
        $scope.alerts.push({message: error.data.message, type: 'danger'})

  $scope.validShowForm = () ->
    $scope.selected.cinema != null && $scope.selected.showType!= null && $scope.selected.movie != null && $scope.selected.screen != null && $scope.selected.date.day != null && $scope.selected.date.time != null


  $scope.collapseScreenAndShowType = () ->
    $scope.selected.cinema == null

  $scope.showAlert = () ->
    $scope.alert.message != undefined and $scope.alert.message != ''

  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1);

])
