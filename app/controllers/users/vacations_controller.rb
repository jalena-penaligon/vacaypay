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

  def vacation_params
    params.require(:vacation).permit(:name, :location, :start_date, :end_date)
  end
end
