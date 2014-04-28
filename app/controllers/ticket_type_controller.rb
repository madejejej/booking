class TicketTypeController < ApplicationController
  respond_to :json

  def index
    show = Show.find(params[:show_id])
    respond_with show.show_type.ticket_types
  end

end
