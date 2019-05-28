class FundingSourcesController < ApplicationController
  def show
    @user = current_user
    @iav = DwollaFundingService.new
    @iav_token = @iav.get_iav_token(current_user)[:token]
    render locals: {
      iav_token:  @iav.get_iav_token(current_user)[:token]
    }
  end
end