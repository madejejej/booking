@controllers.controller( 'SeatEditingController',['$scope', '$window', '$routeParams', 'SeatService', ($scope, $window, $routeParams, SeatService) ->
  window.scope = $scope
  $scope.seats = SeatService.getSeats($routeParams.cinema_id, $routeParams.screen_id)
  $scope.newSeats = []
  $scope.canvas = document.getElementById("seat-canvas")
  $scope.context = $scope.canvas.getContext("2d")
  $scope.layout =
    columns: 1,
    rows: 1

  $scope.redraw = () ->
    $scope.context.fillStyle = "black"
    $scope.context.rect(0 ,0 ,$scope.canvas.width ,$scope.canvas.height)
    $scope.context.fill()
    $scope.canvas.width = $('#seat-canvas-container').width()
    $scope.canvas.height = $('#seat-canvas-container').height()
    $scope.context.rect($scope.canvas.width/20, $scope.canvas.height/20, (18*$scope.canvas.width)/20, (18*$scope.canvas.height)/20)
    $scope.context.stroke()
    drawScreen()
    drawRoom()
    drawOther()

  drawScreen = () ->
    $scope.context.fillStyle = "lightblue"
    $scope.context.fillRect($scope.canvas.width/20, $scope.canvas.height/20, (18*$scope.canvas.width)/20, (2*$scope.canvas.height)/20)
    $scope.context.font = "2em Arial";
    $scope.context.fillStyle= "black"
    $scope.context.textAlign = "center"
    $scope.context.fillText("Screen", $scope.canvas.width/2, 2.5*$scope.canvas.height/20)

  $scope.createSeats = () ->
    $scope.newSeats = []
    if $scope.seats.length == 0
      for row in [1..$scope.layout.rows]
        for col in [1..$scope.layout.columns]
          $scope.newSeats.push
            y: row,
            x: col
    $scope.redraw();

  drawRoom = () ->
    for seat in $scope.newSeats
      rect = roomCoordToScreen(seat)
      $scope.context.beginPath()
      $scope.context.rect(rect.x, rect.y, rect.width, rect.height)
      $scope.context.fillStyle = 'green'
      $scope.context.strokeStyle = 'black'
      $scope.context.fill()
      $scope.context.stroke()

  roomCoordToScreen = (coord) ->
    x = $scope.canvas.width/20+ (((18*$scope.canvas.width)/20)/$scope.layout.columns)*coord.x - ((18*$scope.canvas.width)/20)/$scope.layout.columns
    y = 5*$scope.canvas.height/20 +(((14*$scope.canvas.height)/20)/$scope.layout.rows)*coord.y - ((14*$scope.canvas.height)/20)/$scope.layout.rows
    width = ((18*$scope.canvas.width)/20)/$scope.layout.columns
    height = ((14*$scope.canvas.height)/20)/$scope.layout.rows
    rect =
      x: x,
      y: y,
      width: width,
      height: height
    return rect

  screenCoordToRoom = (coord) ->
    for row in [1..$scope.layout.rows] by 1
      for col in [1..$scope.layout.columns] by 1
        rect = roomCoordToScreen({x: col, y: row})
        if(coord.x >= rect.x && coord.x < rect.x+rect.width && coord.y >= rect.y && coord.y < rect.y+rect.height)
          return {x: col, y: row}

  drawOther = () ->
    $scope.context.font = "1em Arial";
    $scope.context.fillStyle= "black"
    $scope.context.textAlign = "center"
    $scope.context.fillText($scope.layout.rows.toString(), $scope.canvas.width/40, $scope.canvas.height/2)
    $scope.context.fillText($scope.layout.columns.toString(), $scope.canvas.width/2, (39*$scope.canvas.height)/40)

  $scope.select = (event) ->
    x = event.offsetX
    y = event.offsetY
    if(x is undefined)
      x = event.pageX-$('#seat-canvas').offset().left;
      y = event.pageY-$('#seat-canvas').offset().top;
    $scope.coord = screenCoordToRoom({x: x, y: y})
    find = null
    for i in [1..$scope.newSeats.length] by 1
      if($scope.newSeats[i-1].x == $scope.coord.x && $scope.newSeats[i-1].y == $scope.coord.y)
        find = $scope.newSeats[i-1]
    if find is null
      $scope.newSeats.push($scope.coord)
    else
      $scope.newSeats = $scope.newSeats.filter(
        (seat) ->
          !(seat.x==$scope.coord.x && seat.y==$scope.coord.y)
      )
    $scope.redraw();

    return

  angular.element($window).bind 'resize', $scope.redraw
  $scope.createSeats();
  $scope.redraw();
])
