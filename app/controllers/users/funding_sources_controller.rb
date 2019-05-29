class Users::FundingSourcesController < ApplicationController
  def new
    @iav = DwollaFundingService.new
    @user = current_user
    @iav_token = @iav.get_iav_token(current_user)[:token]
  end
end