class Users::VacationsController < ApplicationController

  def index

  end

  def show
    
    render locals: {
      facade: VacationsFacade.new(params[:id])
    }
  end

  def new
    @vacation = Vacation.new
  end

  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      current_user.vacation_users.create(role: 1, vacation: @vacation)
      flash[:success] = "#{@vacation.name} has been created!"
      redirect_to owner_vacation_path(@vacation)
    else
      render :new
    end
  end


  private

  def initial_params
    params.require(:vacation).permit(:name, :city, :state, :country, :start_date, :end_date)
  end

  def vacation_params
    vacation_params = {}
    coordinates = GeoFacade.new(initial_params[:city], initial_params[:state])
    vacation_params[:name] = initial_params[:name]
    vacation_params[:city] = initial_params[:city]
    vacation_params[:state] = initial_params[:state]
    vacation_params[:country] = initial_params[:country]
    vacation_params[:start_date] = initial_params[:start_date]
    vacation_params[:end_date] = initial_params[:end_date]
    vacation_params[:latitude] = coordinates.get_coordinates[0]
    vacation_params[:longitude] = coordinates.get_coordinates[1]
    # binding.pry
    vacation_params
  end

end
