class DwollaOauthService

  def application_token
    application_token = $dwolla.auths.client
  end

  private

end
