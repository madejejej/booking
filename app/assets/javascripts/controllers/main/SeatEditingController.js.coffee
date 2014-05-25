@controllers.controller( 'SeatEditingController',['$scope', '$routeParams', 'SeatService', ($scope, $routeParams, SeatService) ->
  window.scope = $scope
  $scope.seats = SeatService.getSeats($routeParams.cinema_id, $routeParams.screen_id)
  $scope.canvas = document.getElementById('canvas')
  $scope.context = $scope.canvas.getContext("2d")

  $scope.draw = (event) ->
    x = event.offsetX
    y = event.offsetY
    $scope.context.beginPath()
    $scope.context.arc(x, y, 10, 0, 2 * Math.PI);
    $scope.context.fillStyle = 'green';
    $scope.context.fill();
    return
])
