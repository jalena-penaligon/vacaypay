class Owner::VacationsController < ApplicationController

  def show
    render locals: {
      vacation: Vacation.find(params[:id])
    }
  end

end
