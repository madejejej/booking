@App.controller( 'LoginController', ($scope, $http, $animate) ->
  $scope.login_user = {email: null, password: null}

  $scope.login = () ->
    console.log('loggin in')
    $.post('../api/users/sign_in.json',
      user:
        email: $scope.login_user.email,
        password: $scope.login_user.password
    ).success( () ->
      $('#login-field').html('<p>Signed in successfuly</p>')
    )
)
