@controllers.controller('EditScreenDialogController',
  [ '$scope', '$modalInstance', 'cinemaId', 'screen', 'ScreenService', ($scope, $modalInstance, cinemaId, screen, ScreenService) ->

    $scope.header= "Edit screen"
    $scope.button_text = "Edit"
    $scope.oldScreen = screen
    $scope.screen =
      id: $scope.oldScreen.id
      seats: 0
      name: ""

    $scope.validScreenForm = () ->
      if $scope.screen.name is undefined then return false
      return $scope.screen.name.length > 0 && $scope.screen.seats > 0

    $scope.action = () ->
      success = (success) ->
        $modalInstance.close($scope.screen)
      failure = (failure) ->
        $modalInstance.close()
      ScreenService.editScreen(cinemaId, $scope.screen, success, failure)


    $scope.cancel = () ->
      $modalInstance.close()
  ]);
