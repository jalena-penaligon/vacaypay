class Owner::VacationsController < ApplicationController

  def show
    if Vacation.find(params[:id]).host == current_user
      destination = Vacation.find(params[:id])
      @locations = [[destination.city, destination.latitude, destination.longitude]]
      @key = ENV['google_key']
      render locals: {
        facade: VacationsFacade.new(params[:id])
      }
    else render file: "#{Rails.root}/public/404.html" , status: 404
    end
  end

end
