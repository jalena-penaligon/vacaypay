class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user,
                :activity_owner?

  def activity_owner?
    Activity.find(params[:id]).user_id == current_user.id
  end


end
