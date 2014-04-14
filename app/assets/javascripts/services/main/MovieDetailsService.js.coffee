#= require ./services.js
@services.factory("MovieDetailsService", ($resource) ->   
    factory= {}
    factory.query = (movieId) ->
        return $resource("/api/movies/#{movieId}", {},
            query:
                method: "GET"
        ).query()
    factory
)



