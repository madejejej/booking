class MoviesController < ApplicationController
  respond_to :json

  def index
    @movies = Movie.all
    respond_with @movies
  end

end
