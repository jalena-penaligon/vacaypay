class Owner::InvitationsController < ApplicationController

  def new
    @vacation = Vacation.find(params[:vacation_id])
  end

  def create
    owner = current_user
    vacation = Vacation.find(params[:vacation_id])
    emails = params[:email_invitations].split(',').map { |email| email.gsub(" ", "") }
    non_existing_users = User.check_for_existing_users(owner, emails, vacation.id)
    non_existing_users.each do |email|
      VacayInviterMailer.invite(owner, email, vacation).deliver_now
    end
    flash[:notice] = 'Successfully sent invitations!'
    redirect_to owner_vacation_path(vacation.id)
  end

end
