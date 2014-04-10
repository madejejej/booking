class OrganisersController < ApplicationController
  respond_to :json
  before_filter :authenticate_user!

  def create
    begin
      raise StandardError if params[:user_id].to_i != current_user.id
      create_organiser_data! # TODO: to powinno byc gdzie indziej, ale spac mi sie chce
    rescue ActiveRecord::RecordInvalid
      return render json: { errors: $!.to_s }, status: 422
    rescue
      return head :bad_request
    end

    return head :ok
  end


  protected

  def safe_params
    params.permit(organiser_data: [:nip, :name, :description])
  end


  def create_organiser_data!
    ActiveRecord::Base.transaction do
      @organiser_data = OrganiserData.create!(safe_params[:organiser_data])
      current_user.organiser_data = @organiser_data
      current_user.save!
    end
  end
end
