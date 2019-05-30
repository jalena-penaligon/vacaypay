class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user,
                :activity_owner?,
                :vacation_owner?

  def activity_owner?
    Activity.find(params[:id]).user_id == current_user.id
  end

  def vacation_owner?
    Vacation.find(params[:vacation_id]).host == current_user
  end


end
