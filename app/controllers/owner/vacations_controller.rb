class Owner::VacationsController < ApplicationController

  def show
    if Vacation.find(params[:id]).host == current_user
      render locals: {
        facade: VacationsFacade.new(params[:id])
      }
    else render file: "#{Rails.root}/public/404.html" , status: 404
    end
  end

end
