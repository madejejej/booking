@App.controller( 'LoginController', ($scope, $http, $animate) ->
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
      $('#error').hide()
      setTimeout((->  location.reload()), 1500)
    ).error( () ->
      $('#error').html('<p>Invalid username or password!</p>').show()
    )
  $scope.logout = () ->
    $http.delete('../api/users/sign_out.json'
    ).success( () ->
      location.reload()
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
   ).error( () ->

   )
)
