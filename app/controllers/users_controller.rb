class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for registering, you are now logged in as #{@user.email}!"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    @iav = DwollaFundingService.new
    current_user.update!(dwolla_funding_source: @iav.get_funding_source(current_user))
    flash[:success] = "You've connected your bank account."
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
