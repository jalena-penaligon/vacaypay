class Users::ActivitiesController < ApplicationController

  def index

  end

  def show
    render locals: {
      facade: ActivityFacade.new(params[:id])
    }
  end


end
