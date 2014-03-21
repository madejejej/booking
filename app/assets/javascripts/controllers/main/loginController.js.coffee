@App.controller( 'LoginController', ($scope, $http, $animate) ->
  $scope.login_user = {email: null, password: null}

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
)
