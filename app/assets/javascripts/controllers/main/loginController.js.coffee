@controllers.controller( 'LoginController',['$scope','$http','$animate',  ($scope, $http, $animate) ->
  $scope.login_user = {email: null, password: null}
  $scope.register_user =
    email: null
    password: null
    password_confirmation: null

  $scope.login = () ->
    $.post('../api/users/sign_in.json',
      user:
        email: $scope.login_user.email,
        password: $scope.login_user.password
    ).success( () ->
      $('#login-field').html('<p>Signed in successfuly</p>')
      $('#login-error').hide()
      setTimeout((->  window.location = "/"), 1500)
    ).error( () ->
      $('#login-error').show()
    )
  $scope.logout = () ->
    $http.delete('../api/users/sign_out.json'
    ).success( () ->
      window.location = "/"
    )

  $scope.register = () ->
   $http.post('/api/users.json',
     user:
       email: $scope.register_user.email
       password: $scope.register_user.password
       password_confirmation: $scope.register_user.password_confirmation
   ).success( () ->
      $('#register-field').html('<p>Registered successfuly!</p>')
      $scope.login_user.email = $scope.register_user.email
      $scope.login_user.password = $scope.register_user.password
      $scope.login()
   ).error( (response) ->
     console.log(response.errors)
     $scope.error = response.errors
   )
])
