class DwollaFundingService
  def get_iav_token(user)
    token = dwolla_token
    id = user.dwolla_id
    iav_token = token.post "#{id}/iav-token"
  end
  
  private

  def dwolla_token
    @_dwolla_token ||= dwolla_oauth_service.application_token
  end

  def dwolla_oauth_service
    @_oauth_service ||= DwollaOauthService.new
  end
end