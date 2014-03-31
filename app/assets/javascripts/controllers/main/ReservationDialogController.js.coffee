@controllers.controller('ReservationDialogController', [ '$scope', 'showId', ($scope, showId) ->
  $scope.msg = 'hejka z kontolera' + showId
]);