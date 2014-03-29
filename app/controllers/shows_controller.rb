class ShowsController < ApplicationController
  respond_to :json

  def index
    @shows = Movie::Show.where(movie_id: params[:movie_id])
    respond_with @shows
  end

end
