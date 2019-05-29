class Owner::UserActivitiesController < ApplicationController

  def show
  end

  def index
  end

  def create
    params[:user_ids].each do |user_id|
      activity = UserActivity.create(user_id: user_id, quantity: 1, price: associated_activity.price_calculation, paid: false, activity_id: associated_activity.id)
    end
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
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
