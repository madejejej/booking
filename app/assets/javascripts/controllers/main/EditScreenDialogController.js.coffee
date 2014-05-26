@controllers.controller('EditScreenDialogController',
  [ '$scope', '$modalInstance', 'cinemaId', 'screen', 'ScreenService', ($scope, $modalInstance, cinemaId, screenOld, ScreenService) ->

    $scope.header= "Edit screen"
    $scope.button_text = "Edit"
    $scope.screen = jQuery.extend({}, screenOld);
    $scope.areButtonsDisabled = false;
    $scope.errorOccurred = false;

    $scope.validScreenForm = () ->
      if $scope.screen.name is undefined then return false
      return $scope.screen.name.length > 0 && $scope.screen.seats > 0

    $scope.action = () ->
      $scope.areButtonsDisabled = true;
      success = (success) ->
        $modalInstance.close($scope.screen)
      failure = (failure) ->
        $scope.errorOccurred = true;
      ScreenService.editScreen(cinemaId, $scope.screen, success, failure)

    $scope.cancel = () ->
      $modalInstance.close()
  ]);
