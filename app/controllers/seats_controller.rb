class SeatsController < ApplicationController
  respond_to :json

  def index
    @seats = Cinema.find(params[:cinema_id]).screens.find(params[:screen_id]).seats
    respond_with @seats
  end

end
