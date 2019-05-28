class Owner::InvitationsController < ApplicationController

  def new
    @vacation = Vacation.find(params[:vacation_id])
  end

  def create
    vacay_id = params[:vacation_id]
    User.check_for_existing_users(email_to_array, vacay_id)
  end
private

  def email_to_array
    email_string = params[:email_invitations]
    email_string.split(", ")
  end

end
