class Users::UserActivitiesController < ApplicationController

  def create
    associated_activity.increment!(:num_attendees)
    UserActivity.create(user_id: current_user.id, quantity: 1, price: associated_activity.price_calculation, paid: false, activity_id: associated_activity.id)
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
  end

  def destroy
    associated_activity.decrement!(:num_attendees)
    user_activity = UserActivity.where(activity_id: associated_activity.id).find_by(user_id: current_user.id)
    user_activity.delete
    if associated_activity.vacation.vacation_users.where(role: 1)[0].user_id == current_user.id
      redirect_to vacation_owner_activity_path(associated_activity.vacation, associated_activity)
    else
      redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
    end
  end

  private

  def associated_activity
    Activity.find(params[:activity_id])
  end

end
