@controllers.controller('MovieController', 
['$scope', '$routeParams', 'MovieDetailsService', ($scope, $routeParams, MovieDetailsService) ->
    $scope.movie = MovieDetailsService.query($routeParams.movie_id)
])
