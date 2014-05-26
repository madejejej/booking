@controllers.controller('AddScreenDialogController',
    [ '$scope', '$modalInstance', 'cinemaId', 'ScreenService', ($scope, $modalInstance, cinemaId, ScreenService) ->

        $scope.header= "Add screen"
        $scope.button_text = "Create"
        $scope.screen =
            id: -1,
            name: '',
            seats: 0
        $scope.areButtonsDisabled = false;
        $scope.errorOccurred = false;

        $scope.validScreenForm = () ->
            if $scope.screen.name is undefined then return false
            return $scope.screen.name.length > 0

        $scope.action = () ->
            $scope.areButtonsDisabled = true;
            success = (success) ->
                $scope.screen.id = success.id
                $modalInstance.close($scope.screen)
            failure = (failure) ->
                $scope.errorOccurred = true;

            ScreenService.createScreen(cinemaId, $scope.screen, success, failure)


        $scope.cancel = () ->
            $modalInstance.close()







]);
