@controllers.controller('RemoveScreenDialogController',
    [ '$scope', '$modalInstance', 'cinemaId', 'screen', 'ScreenService', ($scope, $modalInstance, cinemaId, screen, ScreenService) ->
        $scope.screen = screen
        $scope.areButtonsDisabled = false;
        $scope.errorOccurred = false;
        $scope.submit = () ->
            $scope.areButtonsDisabled = true;
            success = (success) ->
                $modalInstance.close($scope.screen)
            failure = (failure) ->
                $scope.errorOccurred = true;
            ScreenService.removeScreen(cinemaId, screen, success, failure)

        $scope.cancel = () ->
            $modalInstance.close()

]);
