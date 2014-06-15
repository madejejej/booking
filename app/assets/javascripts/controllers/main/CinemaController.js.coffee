@controllers.controller('CinemaController',
  [ '$scope', '$location', 'CinemaService', ($scope, $location, CinemaService) ->

    $scope.cinema =
      name: '',
      location: '',
      phone: ''

    $scope.validCinemaForm = () ->
      if $scope.cinema.name is undefined or $scope.cinema.location is undefined  or $scope.cinema.phone is undefined then return false
      return true

    $scope.createCinema = ->
      cinema = undefined
      CinemaService.CRUD(name, location, phone).create
        name: $scope.cinema.name
        location: $scope.cinema.location
        phone: $scope.cinema.phone
      ,((successResult) ->
          cinema = successResult
          window.location = "/cinemas/#{cinema.id}"
          $scope.apply()
        ), (errorResult) ->
      return


  ]);