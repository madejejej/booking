@App.factory "httpRequestInterceptor", ($q, $location) ->
  responseError: (rejection) ->
    # do something on error
    if rejection.status is 404
      $location.path "/404"
      $q.reject rejection