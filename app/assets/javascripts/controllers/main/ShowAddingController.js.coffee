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

  $scope.newShow =
    color: '#f00'
    events: []

  startWatchingSelectedDate = ->
    $scope.$watch (->
      $scope.selected.date
    ), (newValue, oldValue)->
      if newValue != oldValue
        $scope.newShow.events[0].start = $scope.selected.date
        $scope.newShow.events[0].end = addMinutesToDate($scope.selected.date, $scope.selected.movie.duration)
        $scope.showsCalendar.fullCalendar( 'rerenderEvents' )
        $scope.showsCalendar.fullCalendar( 'refetchEvents' )


  addMinutesToDate = (date, minutes) ->
    return date if !angular.isDate(date)
    return date.clone().addMinutes(minutes)

  $scope.serverData =
    movies: []
    cinemas: []
    screens: []
    showTypes: []

  MovieService.query( (successResult) ->
    $scope.serverData.movies = successResult;
    angular.forEach(successResult, (movie) ->
      movie.duration = movieDurationToMinutes(movie.duration)
      if movie.id == $scope.movieId
        $scope.selected.movie = movie
        $scope.newShow.events.push
          start: $scope.selected.date
          end: addMinutesToDate($scope.selected.date, $scope.selected.movie.duration)
          title: 'New show'
          type: 'party'
    )
    startWatchingSelectedDate();
  )

  movieDurationToMinutes = (duration)->
    splitted = duration.split(':')
    return parseInt(splitted[0])*60+parseInt(splitted[1])

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


  $scope.screenChanged = (screen) ->
    calendar = $scope.showsCalendar
    updateCalendarEvents(screen, calendar.fullCalendar('getView').start._d, calendar.fullCalendar('getView').end._d)

  updateCalendarEvents = (screen, dateStart, dateEnd) ->
    $scope.events = getEventsByScreenAndDateRange(screen.id, dateStart, dateEnd)
    $scope.eventSources[1] = $scope.events

  getEventsByScreenAndDateRange = (screen_id, dateStart, dateEnd) ->
    shows = ShowService.getByScreenAndDateRange(screen_id, dateStart, dateEnd)
    events = []
    angular.forEach(shows, (show) ->
      event =
        title: show.title
        start: show.date
        end: addMinutesToDate(show.date, $scope.selected.movie.duration)
        editable: false
      events.push(event)
    )
    events

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

  # Change View - fired when date range changed
  $scope.changeView = (view, calendar) ->
    calendar.fullCalendar "changeView", view
    return

  # Change View
  $scope.renderCalendar = (calendar = $scope.showsCalendar) ->
    calendar.fullCalendar "render"
    return


  # alert on eventClick
  $scope.eventClicked = (event, jsEvent, view) ->
    console.log(event.title + ' clicked');
    return


  $scope.viewRendered = () ->
    console.log('View rendered');
    calendar = $scope.showsCalendar
    if $scope.selected.screen != null
      updateCalendarEvents($scope.selected.screen, calendar.fullCalendar('getView').start._d, calendar.fullCalendar('getView').end._d)
    return


  $scope.updateNewShowDateRange = (newStart) ->
    $scope.selected.date = newStart # will fire watch which changes newShow date


  $scope.drop = (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) ->
    console.log('DROPPPED');
    newStart = event._start._d.clone()
    newStart.set
      hour: event._start._i.getHours()
      minute: event._start._i.getMinutes()
      second: event._start._i.getSeconds()
    $scope.updateNewShowDateRange(newStart)
    return
    
  $scope.uiConfig =
    calendar:
      height: 450
      editable: true
      eventClick: $scope.eventClicked
      viewRender: $scope.viewRendered
      eventDrop: $scope.drop


  $scope.eventSources = [$scope.newShow];
])
