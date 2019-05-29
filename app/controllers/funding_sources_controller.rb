class FundingSourcesController < ApplicationController
  def new
    @user = current_user
    @iav = DwollaFundingService.new
    render locals: {
      iav_token:  @iav.get_iav_token(current_user)[:token]
    }
  end
end