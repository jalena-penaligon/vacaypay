class VacationsController < ApplicationController
  def show
    render locals: {
      facade: VacationsFacade.new(params[:id])
    }
  end
end
