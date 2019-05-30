class Owner::UserActivitiesController < ApplicationController

  def show
  end

  def index
  end

  def create
    params[:user_ids].each do |user_id|
      associated_activity.increment!(:num_attendees)
      UserActivity.create(user_id: user_id, quantity: 1, price: associated_activity.price_calculation, paid: false, activity_id: associated_activity.id)
    end
    if associated_activity.vacation.vacation_users.where(role: 1)[0].user_id == current_user.id || associated_activity.user_id == current_user.id
      redirect_to vacation_owner_activity_path(associated_activity.vacation, associated_activity)
    else
      redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
    end
  end

  def new
    ids = associated_activity.user_activities.pluck(:user_id)
    render locals: {
      vacationers: associated_activity.vacation.users.where.not(id: ids),
      activity: associated_activity
    }
  end

  private

  def associated_activity
    Activity.find(params[:activity_id])
  end

end
