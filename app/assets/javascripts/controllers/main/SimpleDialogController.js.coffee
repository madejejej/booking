@controllers.controller('SimpleDialogController',
  [ '$scope', '$modalInstance', ($scope, $modalInstance) ->

    $scope.close = () ->
      $modalInstance.close()

]);
