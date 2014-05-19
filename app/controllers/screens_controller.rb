class ScreensController < ApplicationController
  respond_to :json

  def index
    begin
      Cinema.find(params[:cinema_id])
      @screens = Screen.all_screens_for_cinema_with_seat_count(params[:cinema_id])
      respond_with @screens
    rescue Exception => error
      render json: {message: error.message}, status: :unprocessable_entity # TODO change to proper http response
    end
  end

  def create
    screen_params.inspect
    @screen = Screen.new(screen_params)
    @screen.cinema_id = params[:cinema_id]
    @screen.save
    params['seats'].to_i.times do
      @screen.seats << Seat.create()
    end

    respond_with @screen, location: "/cinemas/#{params[:cinema_id]}/screens"
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
    respond_with @screen, location: "/cinemas/#{params[:cinema_id]}/screens"
  end

  def screen_params
    params.require(:screen).permit(:name, :seats)
  end

end
