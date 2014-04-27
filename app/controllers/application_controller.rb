class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  respond_to :json


  def require_organiser_authentication!
    return redirect_to root_path unless user_signed_in? && current_user.organiser_data.present?
  end
end
