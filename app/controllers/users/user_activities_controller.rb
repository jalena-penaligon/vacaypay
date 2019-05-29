class Users::UserActivitiesController < ApplicationController

  def create
    activity = UserActivity.create(user_id: current_user.id, quantity: 1, price: associated_activity.price_calculation, paid: false, activity_id: associated_activity.id)
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
  end

  def destroy
    user_activity = UserActivity.where(activity_id: associated_activity.id).find_by(user_id: current_user.id)
    user_activity.delete
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
  end

  private

  def associated_activity
    Activity.find(params[:activity_id])
  end

end
