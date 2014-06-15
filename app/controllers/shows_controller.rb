class ShowsController < ApplicationController
  respond_to :json

  def index
    @shows = Show.where(movie_id: 1).includes(screen: [:cinema])
    render json: @shows, include: [:screen, :cinema]
  end

  def create
    begin
      screen = Screen.find(show_params[:screen_id])

      show_type = ShowType.find(show_params[:show_type_id])

      cinema = Cinema.find(show_params[:cinema_id])
      raise 'Cannot add a show to not your cinema you bastard!' if cinema.nil?
      raise 'This cinema does not have such show type available!' unless show_type.cinema == cinema

      screen.add_show(show_params[:movie_id], show_params[:show_type_id], show_params[:datetime].to_time)
    rescue Exception => error
      return render json: {message: error.message}, status: :unprocessable_entity
    end
    render json: {message: 'Show created!'}
  end

  private
  def show_params
    params.require(:show).permit(:movie_id, :screen_id, :cinema_id, :datetime, :show_type_id)
  end


end
