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


  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  # event source that contains custom events on the scope
  $scope.events = [
    {
      title: "All Day Event"
      start: new Date(y, m, 1)
    }
    {
      title: "Long Event"
      start: new Date(y, m, d - 5)
      end: new Date(y, m, d - 2)
    }
  ]

  # event source that calls a function on every view switch
#  $scope.eventsF = (start, end, callback) ->
#   s = new Date(start).getTime() / 1000
#   e = new Date(end).getTime() / 1000
#   m = new Date(start).getMonth()
#   events = [
#     title: "Feed Me " + m
#     start: s + (50000)
#     end: s + (100000)
#     allDay: false
#     className: ["customFeed"]
#   ]
#   callback events
#   return

#  $scope.calEventsExt =
#   color: "#f00"
#   textColor: "yellow"
#   events: [
#     {
#       type: "party"
#       title: "Lunch"
#       start: new Date(y, m, d, 12, 0)
#       end: new Date(y, m, d, 14, 0)
#       allDay: false
#     }
#     {
#       type: "party"
#       title: "Lunch 2"
#       start: new Date(y, m, d, 12, 0)
#       end: new Date(y, m, d, 14, 0)
#       allDay: false
#     }
#   ]


  # alert on eventClick
  $scope.alertOnEventClick = (event, allDay, jsEvent, view) ->
   $scope.alertMessage = (event.title + " was clicked ")
   return


  # alert on Drop
#  $scope.alertOnDrop = (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) ->
#   $scope.alertMessage = ("Event Droped to make dayDelta " + dayDelta)
#   return
#
#
#  # alert on Resize
#  $scope.alertOnResize = (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) ->
#   $scope.alertMessage = ("Event Resized to make dayDelta " + minuteDelta)
#   return
#
#
#  # add and removes an event source of choice
#  $scope.addRemoveEventSource = (sources, source) ->
#   canAdd = 0
#   angular.forEach sources, (value, key) ->
#     if sources[key] is source
#       sources.splice key, 1
#       canAdd = 1
#     return
#
#   sources.push source  if canAdd is 0
#   return
#
#
#  # add custom event
#  $scope.addEvent = ->
#   $scope.events.push
#     title: "Open Sesame"
#     start: new Date(y, m, 28)
#     end: new Date(y, m, 29)
#     className: ["openSesame"]
#
#   return
#
#
#  # remove event
#  $scope.remove = (index) ->
#   $scope.events.splice index, 1
#   return
#

  # Change View
  $scope.changeView = (view, calendar) ->
    calendar.fullCalendar "changeView", view
    return


  # Change View
  $scope.renderCalender = (calendar) ->
    calendar.fullCalendar "render"
    return


  # config object
  $scope.uiConfig = calendar:
    height: 450
    editable: true
    header:
      left: "title"
      center: ""
      right: "today prev,next"

    eventClick: $scope.alertOnEventClick
#    eventDrop: $scope.alertOnDrop
#    eventResize: $scope.alertOnResize

#  $scope.changeLang = ->
#   if $scope.changeTo is "Hungarian"
#     $scope.uiConfig.calendar.dayNames = [
#       "Vasárnap"
#       "Hétfő"
#       "Kedd"
#       "Szerda"
#       "Csütörtök"
#       "Péntek"
#       "Szombat"
#     ]
#     $scope.uiConfig.calendar.dayNamesShort = [
#       "Vas"
#       "Hét"
#       "Kedd"
#       "Sze"
#       "Csüt"
#       "Pén"
#       "Szo"
#     ]
#     $scope.changeTo = "English"
#   else
#     $scope.uiConfig.calendar.dayNames = [
#       "Sunday"
#       "Monday"
#       "Tuesday"
#       "Wednesday"
#       "Thursday"
#       "Friday"
#       "Saturday"
#     ]
#     $scope.uiConfig.calendar.dayNamesShort = [
#       "Sun"
#       "Mon"
#       "Tue"
#       "Wed"
#       "Thu"
#       "Fri"
#       "Sat"
#     ]
#     $scope.changeTo = "Hungarian"
#   return

  $scope.eventSources = [$scope.events, [], []];

])
