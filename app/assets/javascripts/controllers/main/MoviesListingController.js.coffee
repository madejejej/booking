#= require_tree ./
@controllers.controller( 'MoviesListingController',['$scope','MovieService',  ($scope, MoviesService) ->
  $scope.movies = MoviesService.query()
  $scope.aaa = 'aaa'

  $scope.click = () ->
    console.log('asdasadsadsnalskj')


])
