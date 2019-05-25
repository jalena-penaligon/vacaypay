
class Users::DwollasController < ApplicationController


  def create
    token = dwolla_token[:access_token]
  end



  private



  def dwolla_token
    @_dwolla_token ||= service.application_token
  end

  def service
    @_service ||= DwollaOauthService.new
  end


end
