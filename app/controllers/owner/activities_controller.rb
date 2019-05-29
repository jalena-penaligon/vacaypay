class Owner::ActivitiesController < ApplicationController

  def index

  end

  def show
    render locals: {
      facade: OwnerActivityFacade.new(params[:id])
    }
  end

  def new
    @vacation = Vacation.find(params[:vacation_id])
    @activity = Activity.new
  end

  def create  
    @vacation = Vacation.find(params[:vacation_id])
    @activity = @vacation.activities.new(activity_params)
    if @activity.save
      UserActivity.create(user_id: current_user.id, quantity: 1, price: @activity.price_calculation, paid: true, activity_id: @activity.id)
      redirect_to users_vacation_path(@vacation)
    else
      render :new
    end
  end

  def update
    updated_activity = associated_activity.update(update_params)
    if updated_activity.price_changed?
      UserActivity.where(activity_id: associated_activity.id).each do |user_activity|
        user_activity.update_attributes(price: associated_activity.price_calculation)
      end
    end
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
  end

  def delete
    UserActivity.where(activity_id: associated_activity.id).destroy_all
    associated_activity.destroy
    redirect_to users_vacation_path(associated_activity.vacation)
  end

  private

  def activity_params
    params.require(:activity).permit([:name, :description, :price, :cutoff_date, :no_of_days, :type]).merge(user_id: current_user.id, vacation_id: @vacation.id)
  end

  def associated_activity
    Activity.find(params[:activity_id])
  end

end
