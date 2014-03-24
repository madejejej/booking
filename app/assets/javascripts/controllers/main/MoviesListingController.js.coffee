@controllers.controller( 'MoviesListingController',['$scope','MovieService',  ($scope, MoviesService) ->

  $scope.movies = MoviesService.query()

])
