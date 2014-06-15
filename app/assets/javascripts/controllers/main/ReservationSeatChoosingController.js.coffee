@controllers.controller('ReservationSeatChoosingController',
['$scope', '$modalInstance', '$window', 'reservationData', 'showData', 'ScreenService', 'SeatService', 'ReservationService',
($scope, $modalInstance, $window, reservationData, showData, ScreenService, SeatService, ReservationService) ->

  $scope.taken = ReservationService.getReservations(showData.movie_id, showData.id)
  console.log($scope.taken)
  $scope.selected = []
  console.log($scope.taken)
  $scope.screen = ScreenService.getScreen(showData.cinema.id, showData.screen.id,
    (success) ->
      $scope.redraw()
    (error) ->
      $modal.open(
        templateUrl: '<%= asset_path("modals/sadModal.html") %>',
        controller: 'SimpleDialogController'
      ).result.then(() ->
        $location.path("/cinemas/#{showData.cinema.id}/screens")
      )
  )
  $scope.seats = SeatService.getSeats(showData.cinema.id, showData.screen.id,
  (success) ->
    $scope.redraw()
    (error) ->
      $modal.open(
        templateUrl: '<%= asset_path("modals/sadModal.html") %>',
        controller: 'SimpleDialogController'
      ).result.then(() ->
        $location.path("/cinemas/#{showData.cinema.id}/screens")
      )
  )

  $scope.makeReservation = () ->
    reservationData.selected = $scope.selected
    ReservationService.CRUD(showData.movie_id, showData.id).create
      movieId: showData.movie_id
      showId: showData.id
      reservationData
      (success) ->
        $modalInstance.close({message:success.message, type: 'success'})
      (error) ->
        $scope.alert = {message:error.data.message, type: 'danger'}


  $scope.getButtonText = () ->
    if(reservationData.ticketCount - $scope.selected.length== 1)
      return "Please select 1 more seat"
    if($scope.selected.length < reservationData.ticketCount)
      return "Please select #{reservationData.ticketCount-$scope.selected.length} more seats"
    else
      return "Make reservation"
  $scope.validForm = () ->
    return $scope.selected.length - reservationData.ticketCount == 0

  console.log(reservationData)


  $scope.redraw = () ->
    $scope.canvas = document.getElementById("seat-canvas")
    $scope.context = $scope.canvas.getContext("2d")
    $scope.canvas.width = $('#seat-canvas-container').width()
    $scope.canvas.height = $('#seat-canvas-container').height()
    $scope.context.fillStyle = "black"
    $scope.context.rect($scope.canvas.width/20, $scope.canvas.height/20, (18*$scope.canvas.width)/20, (18*$scope.canvas.height)/20)
    $scope.context.fill()
    drawScreen()
    drawRoom()
    drawOther()

  roomCoordToScreen = (coord) ->
    x = $scope.canvas.width/20+ (((18*$scope.canvas.width)/20)/$scope.screen.width)*coord.x - ((18*$scope.canvas.width)/20)/$scope.screen.width
    y = 5*$scope.canvas.height/20 +(((14*$scope.canvas.height)/20)/$scope.screen.height)*coord.y - ((14*$scope.canvas.height)/20)/$scope.screen.height
    width = ((18*$scope.canvas.width)/20)/$scope.screen.width
    height = ((14*$scope.canvas.height)/20)/$scope.screen.height
    rect =
      x: x,
      y: y,
      width: width,
      height: height
    return rect

  screenCoordToRoom = (coord) ->
    for row in [1..$scope.screen.height] by 1
      for col in [1..$scope.screen.width] by 1
        rect = roomCoordToScreen({x: col, y: row})
        if(coord.x >= rect.x && coord.x < rect.x+rect.width && coord.y >= rect.y && coord.y < rect.y+rect.height)
          return {x: col, y: row}

  $scope.select = (event) ->
    x = event.offsetX
    y = event.offsetY
    if(x is undefined)
      x = event.pageX-$('#seat-canvas').offset().left;
      y = event.pageY-$('#seat-canvas').offset().top;
    coord = screenCoordToRoom({x: x, y: y})
    find = null
    for i in [1..$scope.seats.length] by 1
      if($scope.seats[i-1].x == coord.x && $scope.seats[i-1].y == coord.y)
        find = $scope.seats[i-1]
    if !(find is null)
      isTaken = false
      isSelected = false;
      for i in [1..$scope.taken.length] by 1
        if($scope.taken[i-1].x == coord.x && $scope.taken[i-1].y == coord.y)
          isTaken = true
      if(!isTaken)
        for i in [1..$scope.selected.length] by 1
          if($scope.selected[i-1].x == coord.x && $scope.selected[i-1].y == coord.y)
            isSelected= true
        if isSelected
          $scope.selected = $scope.selected.filter(
            (seat) ->
              !(seat.x==coord.x && seat.y==coord.y)
          )
        else if reservationData.ticketCount > $scope.selected.length
          $scope.selected.push(coord)

    $scope.redraw();
    return

  drawScreen = () ->
    $scope.context.fillStyle = "lightblue"
    $scope.context.fillRect($scope.canvas.width/20, $scope.canvas.height/20, (18*$scope.canvas.width)/20, (2*$scope.canvas.height)/20)
    $scope.context.font = "2em Arial";
    $scope.context.fillStyle= "black"
    $scope.context.textAlign = "center"
    $scope.context.fillText("Screen", $scope.canvas.width/2, 2.5*$scope.canvas.height/20)

  drawRoom = () ->
    for seat in $scope.seats
      rect = roomCoordToScreen(seat)
      $scope.context.beginPath()
      $scope.context.rect(rect.x, rect.y, rect.width, rect.height)
      $scope.context.fillStyle = 'green'
      $scope.context.strokeStyle = 'black'
      $scope.context.fill()
      $scope.context.stroke()
    for seat in $scope.taken
      rect = roomCoordToScreen(seat)
      $scope.context.beginPath()
      $scope.context.rect(rect.x, rect.y, rect.width, rect.height)
      $scope.context.fillStyle = 'red'
      $scope.context.strokeStyle = 'black'
      $scope.context.fill()
      $scope.context.stroke()
    for seat in $scope.selected
      rect = roomCoordToScreen(seat)
      $scope.context.beginPath()
      $scope.context.rect(rect.x, rect.y, rect.width, rect.height)
      $scope.context.fillStyle = 'yellow'
      $scope.context.strokeStyle = 'black'
      $scope.context.fill()
      $scope.context.stroke()

  roomCoordToScreen = (coord) ->
    x = $scope.canvas.width/20+ (((18*$scope.canvas.width)/20)/$scope.screen.width)*coord.x - ((18*$scope.canvas.width)/20)/$scope.screen.width
    y = 5*$scope.canvas.height/20 +(((14*$scope.canvas.height)/20)/$scope.screen.height)*coord.y - ((14*$scope.canvas.height)/20)/$scope.screen.height
    width = ((18*$scope.canvas.width)/20)/$scope.screen.width
    height = ((14*$scope.canvas.height)/20)/$scope.screen.height
    rect =
      x: x,
      y: y,
      width: width,
      height: height
    return rect

  drawOther = () ->
    $scope.context.font = "1em Arial";
    $scope.context.fillStyle= "black"
    $scope.context.textAlign = "center"
    $scope.context.fillText($scope.screen.height.toString(), $scope.canvas.width/80, $scope.canvas.height/2)
    $scope.context.fillText($scope.screen.width.toString(), $scope.canvas.width/2, (79*$scope.canvas.height)/80)

  angular.element($window).bind 'resize', $scope.redraw
]);