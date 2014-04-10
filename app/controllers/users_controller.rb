class UsersController < ApplicationController

  def whoami
    if current_user
      respond_with current_user
    else
      head :not_found
    end
  end
end
