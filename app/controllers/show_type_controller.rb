class ShowTypeController < ApplicationController
  respond_to :json


  def index
    @cinema = Cinema.find(params[:cinema_id])
    respond_with @cinema.show_types
  end

end