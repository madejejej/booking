@controllers.controller( 'ShowAddingController',['$scope','$location','$routeParams', 'ShowService',  ($scope, $location,$routeParams, MovieService) ->
  console.log($routeParams.movie_id);
])
