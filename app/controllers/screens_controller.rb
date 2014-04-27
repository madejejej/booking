class ScreensController < ApplicationController
  respond_to :json

  def index
    @screens = Screen.all_screens_for_cinema_with_seat_count(params[:cinema_id])
    respond_with @screens
  end

end
