@services.factory('ShowTypeService', ($resource) ->

  $resource("/api/cinemas/:cinema_id/show_type",
    cinema_id: "@cinema_id"
    query:
      method: "GET"
      isArray: true
  )

)