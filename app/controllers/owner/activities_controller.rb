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
    binding.pry
    @activity = @vacation.activities.new(activity_params)
    if @activity.save
      UserActivity.create(user_id: current_user.id, quantity: 1, price: @activity.price_calculation, paid: true, activity_id: @activity.id)
      if @vacation.host == current_user
        redirect_to owner_vacation_path(@vacation)
      else
        redirect_to users_vacation_path(@vacation)
      end
    else
      render :new
    end
  end

  def mass_invite
    ids = mass_invite_activity.user_activities.pluck(:user_id)
    Vacation.find(params[:id]).users.where.not(id: ids).distinct.each do |user|
      mass_invite_activity.increment!(:num_attendees)
      UserActivity.create(user_id: user.id, quantity: 1, price: mass_invite_activity.price_calculation, paid: false, activity_id: mass_invite_activity.id)
      mass_invite_activity.user_activities.each do |ua|
        ua.price = mass_invite_activity.price_calculation
      end
    end
    if Vacation.find(params[:id]).host.id == current_user.id
      binding.pry
      redirect_to owner_vacation_path(Vacation.find(params[:id]))
    else
      redirect_to users_vacation_path(Vacation.find(params[:id]))
    end
  end

  def edit
    @vacation = Vacation.find(params[:vacation_id])
    @activity = associated_activity
  end

  def update
    stale_price_param = associated_activity.price
    associated_activity.update(update_params)
    if price_change?(stale_price_param)
      UserActivity.where(activity_id: associated_activity.id).each do |user_activity|
        user_activity.update_attributes(price: associated_activity.price_calculation)
      end
    end
    redirect_to users_vacation_activity_path(associated_activity.vacation, associated_activity)
  end

  def destroy
    UserActivity.where(activity_id: associated_activity.id).destroy_all
    associated_activity.destroy
    redirect_to users_vacation_path(associated_activity.vacation)
  end

  def remove
    associated_activity.decrement!(:num_attendees)
    user_activity = UserActivity.where(activity_id: associated_activity.id).find_by(user_id: params[:user_id])
    user_activity.delete
    if vacation_owner?
      redirect_to owner_vacation_path(associated_activity.vacation)
    else
      redirect_to vacation_owner_activity_path(associated_activity.vacation, associated_activity)
    end
  end

  private

  def activity_params
    params.require(:activity)
          .permit([:name,
                  :description,
                  :street,
                  :city,
                  :state,
                  :postal_code,
                  :country,
                  :price,
                  :cutoff_date,
                  :no_of_days,
                  :type])
            .merge(user_id: current_user.id,
                  vacation_id: @vacation.id)
                  # latitude: ActivityGeoFacade.new(params[:street],
                  #                                 params[:city],
                  #                                 params[:state])
                  #                           .get_coordinates[0],
                  # longitude: ActivityGeoFacade.new(params[:street],
                  #                                 params[:city],
                  #                                 params[:state])
                  #                           .get_coordinates[1])
  end

  # def activity_params
  #   activity_params = {}
  #   coordinates = ActivityGeoFacade.new(params[:street],
  #                                   params[:city],
  #                                   params[:state])
  #   activity_params[:name] = initial_params[:name]
  #   activity_params[:description] = initial_params[:description]
  #   activity_params[:street] = initial_params[:street]
  #   activity_params[:city] = initial_params[:city]
  #   activity_params[:state] = initial_params[:state]
  #   activity_params[:postal_code] = initial_params[:postal_code]
  #   activity_params[:country] = initial_params[:country]
  #   activity_params[:price] = initial_params[:price]
  #   activity_params[:cutoff_date] = initial_params[:name]
  #   activity_params[:no_of_days] = initial_params[:no_of_days]
  #   activity_params[:type] = initial_params[:type]
  #   activity_params[:latitude] = coordinates.get_coordinates[0]
  #   activity_params[:longitude] = coordinates.get_coordinates[1]
  # end

  # def coordinates
  #   binding.pry
  #   ActivityGeoFacade.new(params[:street],
  #                         params[:city],
  #                         params[:state])
  # end

  def update_params
    if params.has_key?(:fixed_cost)
      params[:client] = params.delete(:fixed_cost)
    elsif params.has_key?(:per_person_cost)
      params[:client] = params.delete(:per_person_cost)
    end
    params.require(:client).permit([:name, :description, :price, :cutoff_date, :no_of_days, :type])
  end

  def associated_activity
    @_activity ||= Activity.find(params[:id])
  end

  def mass_invite_activity
    @_mass_invite_activity ||= Activity.find(params[:activity_id])
  end

  def price_change?(stale_price_param)
    stale_price_param != update_params[:price]
  end

end
