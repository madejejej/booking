class ScreensController < ApplicationController
  respond_to :json

  def index
    @screens = Screen.all_screens_for_cinema_with_seat_count(params[:cinema_id])
    respond_with @screens
  end

  def create
    @screen = Screen.new(screen_params)
    @screen.cinema_id = params[:cinema_id]
    @screen.save
    params["seats"].to_i.times do
      @screen.seats << Seat.create()
    end
    @cinema = @screen.cinema
    respond_with @cinema, @screen
  end

  def destroy
    @screen = Screen.find(params[:screen_id]).destroy
    respond_with @screen, location: "/cinemas/#{params[:cinema_id]}/screens"
  end

  def update
    @screen = Screen.find(params[:screen_id])
    @screen.update_attributes(name: screen_params["name"])
    @screen.seats.destroy_all
    params["seats"].to_i.times do
      @screen.seats << Seat.create()
    end
    @cinema = @screen.cinema
    respond_with @cinema, @screen
  end

  def screen_params
    params.require(:screen).permit(:name, :seats)
  end

end
