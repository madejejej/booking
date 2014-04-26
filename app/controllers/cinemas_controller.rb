class CinemasController < ApplicationController
  respond_to :json

  def list
    @cinemas = Cinema.find_by(user: current_user)
    respond_with @cinemas
  end

  def create
    @cinema = Cinema.new(params[:cinema].permit(:name, :location))
    @cinema.organiser_data = current_user.organizer_data
    if @cinema.save
      redirect_to list
    end
  end

  def delete
    @cinema = Cinema.find(params[:id])
    @cinema.destroy
    redirect_to list
  end

  def update
    @cinema = Cinema.find(params[:id])
    if @cinema.update(params[:cinema].permit(:name, :location))
      redirect_to list
    end
  end

end
