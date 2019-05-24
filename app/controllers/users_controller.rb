class UsersController < ApplicationController
  def create
    profile_info = paypal_data
    email = profile_info[:emails][0][:value]
    name = profile_info[:name]
    @user = User.find_or_create_by(email: email) do |block|
      block.name = name
    end
    if @user
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  end
  #
  # def create
  #   binding.pry
  #   response = request.env['omniauth.auth']
  #   name = response['info']['name']
  #   email = response['info']['email']
  #   paypal_token = respone['credentials']['token']
  #
  #   user = User.create(name: name, email: email ,paypal_token: paypal_token)
  #   if user.save
  #     session[:user_id] = user.id
  #     redirect_to dashboard_path
  #   end
  # end

  def update

  end

  private

  def paypal_data
    @_paypal_data ||= service.paypal_info
  end

  def service
    @_service ||= SandboxPaypalService.new(params[:code])
  end


end
