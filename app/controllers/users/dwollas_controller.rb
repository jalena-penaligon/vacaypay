class Users::DwollasController < ApplicationController

  def new
  end

  def create
    token = dwolla_token
    response = dwolla_customer_location(token)
    current_user.update(dwolla_id: response.response_headers[:location])
    redirect_to root_path
  end

  def transfer
    token = dwolla_token
    response = dwolla_transfer(token)
    #possible model push
    activity = UserActivity.find_by(activity_id: params[:activity_id], user_id: current_user.id)
    activity.update(paid: true)
    activity = Activity.find(params[:activity_id])
    flash[:success] = "You successfully paid for #{activity.name}."
    redirect_to vacation_path(activity.vacation)
  end

  private

  def dwolla_customer_location(token)
    @_customer_location ||= dwolla_customer_service(token).create_verified_user
  end

  def dwolla_token
    @_dwolla_token ||= dwolla_oauth_service.application_token
  end

  def dwolla_oauth_service
    @_oauth_service ||= DwollaOauthService.new
  end

  def dwolla_customer_service(token)
    @_customer_service ||= DwollaCustomerService.new(current_user, user_params, token)
  end

  def dwolla_transfer_service(token)
    activity = Activity.find(params[:activity_id])
    source = current_user.dwolla_funding_source
    destination = User.find(activity.user_id).dwolla_funding_source
    user_activity = UserActivity.find_by(activity_id: params[:activity_id], user_id: current_user.id)
    @_transfer_service ||= DwollaTransferService.new(source, destination, user_activity, token)
  end

  def dwolla_transfer(token)
    service = dwolla_transfer_service(token)
    service.create_transfer
  end


  # def dwolla_transfer(token)
  #   @_dwolla_transfer = dwolla_transfer_service(token).create_transfer
  # end

  def user_params
    params.permit(:address, :city, :state, :postal_code, :dob, :ssn)
  end

end
