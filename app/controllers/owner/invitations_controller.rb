class Owner::InvitationsController < ApplicationController

  def new
    @vacation = Vacation.find(params[:vacation_id])
  end

  def create
    user = current_user
    vacation = Vacation.find(params[:vacation_id])
    email_list = User.check_for_existing_users(email_to_array, vacation.id)
    VacayInviterMailer.invite(user, email_list, vacation).deliver_now
    flash[:notice] = 'Successfully sent invitations!'
    redirect_to owner_vacation_path(vacation.id)
  end
private

  def email_to_array
    email_string = params[:email_invitations]
    email_string.split(", ")
  end

end
