class SeatsController < ApplicationController
  respond_to :json

  def index
    @seats = Cinema.find(params[:cinema_id]).screens.find(params[:screen_id]).seats
    respond_with @seats
  end

  def create
    ActiveRecord::Base.transaction do
      @screen = Screen.find(params[:screen_id])
      @screen.width = params[:layout]['columns']
      @screen.height = params[:layout]['rows']
      @screen.save
      params[:seats].each do |item|
        seat = Seat.new
        seat.screen = @screen
        seat.x = item['x']
        seat.y = item['y']
        seat.save()
      end
    end
    @cinema = @screen.cinema
    respond_with @cinema, @screen
  end

end
