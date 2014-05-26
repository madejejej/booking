class SeatsController < ApplicationController
  respond_to :json

  def index
    @seats = Cinema.find(params[:cinema_id]).screens.find(params[:screen_id]).seats
    respond_with @seats
  end

  def create
    ActiveRecord::Base.transaction do
      @screen = Screen.find(params[:screen_id])
      JSON.parse(params[:seats]).each do |item|
        seat = Seat.new
        seat.screen = @screen
        seat.x = item['x']
        seat.y = item['y']
      end
    end
    @cinema = @screen.cinema
    respond_with @cinema, @screen
  end

end
