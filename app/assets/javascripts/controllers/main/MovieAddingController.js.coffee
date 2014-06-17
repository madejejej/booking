#angular.module('App', ['angularFileUpload'])

@controllers.controller('MovieAddingController',
  [ '$scope', '$modal',  '$location', '$fileUploader', 'MovieService', ($scope, $modal, $location, $fileUploader, MovieService) ->
    $scope.movie =
      title: '',
      description: '',
      cover: '',
      director: '',
      duration: ''

    $scope.validMovieForm = () ->
      if $scope.movie.title is undefined or $scope.movie.description is undefined  or $scope.movie.duration is undefined then return false
      return true

    $scope.createMovie = () ->
      $scope.uploader.formData.push
        title: $scope.movie.title
      $scope.uploader.uploadAll()
      #MovieService.create($scope.movie, uploader.queue.pop().file)
      return

    csrf_token = document.querySelector("meta[name=\"csrf-token\"]").getAttribute("content")

    # create a uploader with options
    $scope.uploader = $fileUploader.create(
      scope: $scope # to automatically update the html. Default: $rootScope
      url: "/api/movies"
      alias: "cover"
      formData: []
      filters: [(item) -> # first user filter
        console.info "filter1"
        true
      ]
      headers:
        "X-CSRF-TOKEN": csrf_token
    )

    # FAQ #1
    item =
      file:
        name: "Previously uploaded file"
        size: 1e6

      progress: 100
      isUploaded: true
      isSuccess: true

    item.remove = ->
      $scope.uploader.removeFromQueue this
      return

    $scope.uploader.queue.push item
    $scope.uploader.progress = 100

# ADDING FILTERS
    $scope.uploader.filters.push (item) -> # second user filter
      console.info "filter2"
      true


# REGISTER HANDLERS
    $scope.uploader.bind "afteraddingfile", (event, item) ->
      console.info "After adding a file", item
      return

    $scope.uploader.bind "whenaddingfilefailed", (event, item) ->
      console.info "When adding a file failed", item
      return

    $scope.uploader.bind "afteraddingall", (event, items) ->
      console.info "After adding all files", items
      return

    $scope.uploader.bind "beforeupload", (event, item) ->
      console.info "Before upload", item
      item.formData.push
        title: $scope.movie.title

      item.formData.push
        description: $scope.movie.description

      item.formData.push
        director: $scope.movie.director

      item.formData.push
        duration: $scope.movie.duration
      return

    $scope.uploader.bind "progress", (event, item, progress) ->
      console.info "Progress: " + progress, item
      return

    $scope.uploader.bind "success", (event, xhr, item, response) ->
      console.info "Success", xhr, item, response
      return

    $scope.uploader.bind "cancel", (event, xhr, item) ->
      console.info "Cancel", xhr, item
      return

    $scope.uploader.bind "error", (event, xhr, item, response) ->
      console.info "Error", xhr, item, response
      return

    $scope.uploader.bind "complete", (event, xhr, item, response) ->
      console.info "Complete", xhr, item, response
      return

    $scope.uploader.bind "progressall", (event, progress) ->
      console.info "Total progress: " + progress
      return

    $scope.uploader.bind "completeall", (event, items) ->
      console.info "Complete all", items
      return


  ]);