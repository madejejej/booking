@controllers.controller('MovieController', 
['$scope', '$routeParams', 'MovieDetailsService', ($scope, $routeParams, MovieDetailsService) ->    
    $scope.movie = MovieDetailsService.query({movie_id: $routeParams.movie_id})
    $scope.name = "Kasia"
    alert "Halo"
])
