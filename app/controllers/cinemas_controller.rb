class CinemasController < ApplicationController
  respond_to :json
  before_action :require_organiser_authentication!, except: :show

  def index
    @cinemas = current_user.organiser_data.cinemas
    respond_with @cinemas
  end

  def show
    begin
      @cinema = Cinema.find(params[:id])
      respond_with @cinema
    rescue Exception => e
      render json: {message: e.message}, status: :not_found
    end
  end

  def create
    @cinema = Cinema.new(params[:cinema].permit(:name, :location, :phone))
    @cinema.organiser_data = current_user.organiser_data
    @cinema.save
    respond_with @cinema
  end

  def destroy
    @cinema = Cinema.find(params[:id])
    @cinema.destroy
    respond_with true
  end

  def update
    @cinema = Cinema.find(params[:id])
    @cinema.update_attributes(params.permit(:name, :location, :phone))
    respond_with @cinema
  end

end
