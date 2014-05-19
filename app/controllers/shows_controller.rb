class ShowsController < ApplicationController
  respond_to :json

  def index
    @shows = Show.all_for_movie_with_screen(params[:movie_id])
    respond_with @shows
  end

  def create
    begin
      screen = Screen.find(show_params[:screen_id])
      raise 'No such screen exists!' if screen.nil?

      show_type = ShowType.find(show_params[:show_type_id])
      raise 'No such show type exists' if show_type.nil?

      cinema = current_user.organiser_data.cinemas.select {|c| c.screens.contains(screen)}.first
      raise 'Cannot add a show to not your cinema you bastard!' if cinema.nil?

      raise 'This cinema does not have such show type available!' unless cinema.show_types.contains(show_type)
      screen.add_show(show_params[:movie_id], show_params[:show_type_id], show_params[:datetime])

    rescue Exception => error
      return render json: {message: error.message}, status: :unprocessable_entity
    end
    render json: {message: 'Show created!'}
  end

  private
  def show_params
    params.require(:show).permit(:movie_id, :screen_id, :datetime, :show_type_id)
  end


end
