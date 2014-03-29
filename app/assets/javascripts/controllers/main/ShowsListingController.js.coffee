@controllers.controller( 'ShowsListingController',['$scope', '$routeParams', 'ShowService',  ($scope, $routeParams, ShowService) ->

  $scope.shows = ShowService.query($routeParams.movie_id)

])
