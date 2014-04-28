@controllers.controller('RemoveScreenDialogController',
    [ '$scope', '$modalInstance', 'cinemaId', 'screen', 'ScreenService', ($scope, $modalInstance, cinemaId, screen, ScreenService) ->
        $scope.screen = screen
        $scope.submit = () ->
            success = (success) ->
                $modalInstance.close($scope.screen)
            failure = (failure) ->
                $modalInstance.close()
            ScreenService.removeScreen(cinemaId, screen, success, failure)

        $scope.cancel = () ->
            $modalInstance.close()

]);
