class Users::ActivitiesController < ApplicationController

  def index

  end

  def show
    render locals: {
      facade: ActivityFacade.new(params[:id])
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
      UserActivity.create(user_id: current_user.id, quantity: 1, price: @activity.price_calculation, paid: false, activity_id: @activity.id)
      redirect_to users_vacation_path(@vacation)
    else
      render :new
    end
  end
end
