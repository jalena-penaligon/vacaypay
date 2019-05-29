class Users::FundingSourcesController < ApplicationController
  def new
    @iav = DwollaFundingService.new
    @user = current_user
    @iav_token = @iav.get_iav_token(current_user)[:token]
  end
  
  def update
    @iav = DwollaFundingService.new
    current_user.update!(dwolla_funding_source: @iav.get_funding_source(current_user))
    flash[:success] = "You've connected your bank account."
    redirect_to dashboard_path
  end
end