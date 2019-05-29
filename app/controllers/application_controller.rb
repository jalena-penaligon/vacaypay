class ApplicationController < ActionController::Base
  helper_method :current_user,
                :activity_owner?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def activity_owner?
    Activity.find(params[:id]).user_id == current_user.id
  end


end
