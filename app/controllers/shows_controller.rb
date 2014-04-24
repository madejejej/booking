class ShowsController < ApplicationController
  respond_to :json

  def index
    @shows = Show.all_for_movie_with_screen(params[:movie_id])
    respond_with @shows
  end

end
