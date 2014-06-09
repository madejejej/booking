@controllers.controller('MovieAddingController',
  [ '$scope', '$modal',  '$location', 'MovieService', ($scope, $modal, $location, MovieService) ->
    $scope.movie =
      title: '',
      description: '',
      cover_url: '',
      director: '',
      duration: ''

    $scope.validMovieForm = () ->
      if $scope.movie.title is undefined or $scope.movie.description is undefined  or $scope.movie.duration is undefined then return false
      return true

    $scope.createMovie = () ->
      MovieService.create($scope.movie)
      return

]);