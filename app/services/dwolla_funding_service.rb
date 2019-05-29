class DwollaFundingService
  def get_iav_token(user)
    token = dwolla_token
    id = user.dwolla_id
    iav_token = token.post "#{id}/iav-token"
  end

  def get_funding_source(user)
    token = dwolla_token
    customer_url = user.dwolla_id
    funding_sources = token.get "#{customer_url}/funding-sources"
    funding_sources._embedded['funding-sources'][0].name
  end

  private

  def dwolla_token
    @_dwolla_token ||= dwolla_oauth_service.application_token
  end

  def dwolla_oauth_service
    @_oauth_service ||= DwollaOauthService.new
  end
end