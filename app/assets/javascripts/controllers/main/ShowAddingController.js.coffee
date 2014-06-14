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
    ), ->
      console.log('IN WATCH');
      $scope.newShow.events[0].start = $scope.selected.date
      $scope.newShow.events[0].end = addMinutesToDate($scope.selected.date, $scope.selected.movie.duration)
      $scope.showsCalendar.fullCalendar( 'refetchEvents' )
      $scope.showsCalendar.fullCalendar( 'rerenderEvents' )


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

  CinemaService.list ((successResult) ->
    $scope.serverData.cinemas = successResult
  ), (errorResult) ->
    $scope.alerts.push({message: errorResult.data.message, type: 'danger'})


  movieDurationToMinutes = (duration)->
    splitted = duration.split(':')
    return parseInt(splitted[0])*60+parseInt(splitted[1])


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


  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  # event source that contains custom events on the scope
  $scope.events = [
    {
      title: "All Day Event"
      start: new Date(y, m, d,12,0)
      end: new Date(y, m, d,14,0)
      editable: false
    }
    {
      title: "Long Event"
      start: new Date(y, m, d ,11,0)
      end: new Date(y, m, d, 13,0)
      className: 'gcal-event'
      editable: false
    }
  ]




  # remove event
  $scope.remove = (calendar) ->
    $scope.events.splice 0, 1
    console.log($scope.events)
    calendar.fullCalendar( 'refetchEvents' )
    calendar.fullCalendar( 'rerenderEvents' )
    console.log(calendar.fullCalendar('getView').start);
    console.log(calendar.fullCalendar('getView').end);
    $scope.$watch (->
      $scope.showsCalendar.fullCalendar('getView').start
    ), ->
      console.log($scope.showsCalendar.fullCalendar('getView').start);
    return
#

  # Change View
  $scope.changeView = (view, calendar) ->
    calendar.fullCalendar "changeView", view
    return


  # Change View
  $scope.renderCalender = (calendar) ->
    calendar.fullCalendar "render"
    return


  # alert on eventClick
  $scope.eventClicked = (event, jsEvent, view) ->
    console.log(event.title + ' clicked');
    return


  $scope.viewRendered = () ->
    console.log('View rendered');
    # TODO refresh shows from backend by dates
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
    
  # config object
  $scope.uiConfig =
    calendar:
      height: 450
      editable: true
      eventClick: $scope.eventClicked
      viewRender: $scope.viewRendered
      eventDrop: $scope.drop


  $scope.eventSources = [$scope.newShow,$scope.events];

#  calendarDateRangeListener = () ->
#    $scope.showsCalendar.fullCalendar viewRender: (view, element) ->
#        console.log(view);







])
